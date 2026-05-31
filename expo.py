import mysql.connector

copa_expo = mysql.connector.connect(
    host='localhost',
    user='root',
    password='root',
    database='copa_expo'
)

cursorcp = copa_expo.cursor()



def login():

    Nome = input('Digite seu nome: ')
    Email = input('Digite seu email: ')
    Senha = input('Digite sua senha: ')

    sql = """
    INSERT INTO Usuario (usu_nome, usu_email, usu_senha)
    VALUES (%s, %s, %s)
    """

    cursorcp.execute(sql, (Nome, Email, Senha))
    copa_expo.commit()

    print('Seja bem-vindo(a)', Nome)

    return cursorcp.lastrowid



def menu(usuario_logado):

    while True:
        print('\n===== MENU =====')
        print('1 - Ver Álbum')
        print('2 - Minhas Figurinhas')
        print('3 - Figurinhas Faltantes')
        print('4 - Cadastrar Figurinha')
        print('5 - Sair')

        opcao = input('Escolha uma opção: ')

        if opcao == '1':
            ver_album()
        elif opcao == '2':
            minhas_figurinhas(usuario_logado)
        elif opcao == '3':
            figurinhas_faltantes(usuario_logado)
        elif opcao == '4':
            cadastrar_figurinha(usuario_logado)
        elif opcao == '5':
            print('Saindo...')
            break
        else:
            print('Opção inválida')



def ver_album():

    sql = """
    SELECT 
        Jogador.jog_id,
        Jogador.jog_nome,
        Jogador.jog_pos,
        Jogador.jog_num,
        Selecao.sel_pais
    FROM Jogador
    INNER JOIN Selecao
    ON Jogador.id_selecao = Selecao.sel_id
    """

    cursorcp.execute(sql)
    resultado = cursorcp.fetchall()

    print("\n=== ÁLBUM ===\n")

    for j in resultado:
        print(f'ID Jogador: {j[0]} | Nome: {j[1]} | Posição: {j[2]} | Número: {j[3]} | País: {j[4]}')



def cadastrar_figurinha(usu_id):

    print("\n=== FIGURINHAS DISPONÍVEIS ===")

    cursorcp.execute("""
        SELECT f.fig_id, j.jog_nome, s.sel_pais
        FROM Figurinha f
        INNER JOIN Jogador j ON f.id_jogador = j.jog_id
        INNER JOIN Selecao s ON j.id_selecao = s.sel_id
        ORDER BY f.fig_id
    """)

    resultados = cursorcp.fetchall()

    for f in resultados:
        print(f"ID Figurinha: {f[0]} | Jogador: {f[1]} | País: {f[2]}")

    print("\n=== CADASTRAR FIGURINHA ===")

    id_fig = int(input("Digite o ID da figurinha: "))

    
    cursorcp.execute("""
        SELECT fig_id FROM Figurinha WHERE fig_id = %s
    """, (id_fig,))

    if cursorcp.fetchone() is None:
        print("❌ Essa figurinha não existe!")
        return

 
    cursorcp.execute("""
        SELECT * FROM Colecao
        WHERE id_usuario = %s AND id_figurinha = %s
    """, (usu_id, id_fig))

    if cursorcp.fetchone():
        print("Você já tem essa figurinha!")
        return

  
    cursorcp.execute("""
        INSERT INTO Colecao (id_usuario, id_figurinha)
        VALUES (%s, %s)
    """, (usu_id, id_fig))

    copa_expo.commit()

    print(f"✔ Figurinha {id_fig} cadastrada com sucesso!")


def minhas_figurinhas(usu_id):

    sql = """
    SELECT 
        Jogador.jog_id,
        Jogador.jog_nome,
        Selecao.sel_pais,
        Figurinha.fig_raridade
    FROM Colecao
    INNER JOIN Figurinha ON Colecao.id_figurinha = Figurinha.fig_id
    INNER JOIN Jogador ON Figurinha.id_jogador = Jogador.jog_id
    INNER JOIN Selecao ON Jogador.id_selecao = Selecao.sel_id
    WHERE Colecao.id_usuario = %s
    """

    cursorcp.execute(sql, (usu_id,))
    resultado = cursorcp.fetchall()

    print("\n=== MINHAS FIGURINHAS ===\n")

    if not resultado:
        print("Você ainda não possui figurinhas.")
        return

    for f in resultado:
        print(f"ID Jogador: {f[0]} | Jogador: {f[1]} | País: {f[2]} | Raridade: {f[3]}")



def figurinhas_faltantes(usu_id):

    sql = """
    SELECT
        f.fig_id,
        j.jog_nome,
        s.sel_pais,
        f.fig_raridade
    FROM Figurinha f
    INNER JOIN Jogador j ON f.id_jogador = j.jog_id
    INNER JOIN Selecao s ON j.id_selecao = s.sel_id
    LEFT JOIN Colecao c 
        ON c.id_figurinha = f.fig_id 
        AND c.id_usuario = %s
    WHERE c.id_figurinha IS NULL
    ORDER BY f.fig_id
    """

    cursorcp.execute(sql, (usu_id,))
    resultado = cursorcp.fetchall()

    print("\n=== FIGURINHAS FALTANTES ===\n")

    for f in resultado:
        print(f"ID Figurinha: {f[0]} | Jogador: {f[1]} | País: {f[2]} | Raridade: {f[3]}")



usuario = login()
menu(usuario)