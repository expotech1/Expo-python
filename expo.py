import mysql.connector
copa_expo = mysql.connector.connect(
    host = 'localhost',
    user = 'root',
    password = 'root',
    database = 'copa_expo'
    )

cursorcp = copa_expo.cursor()

def login():
    
        while True:
            Nome = input('Digite seu nome:')
            sql = """
            SELECT * FROM Usuario
            WHERE usu_nome = %s
            """
            
            cursorcp.execute(sql, (Nome,))
            login_correto = cursorcp.fetchone()
            
            if login_correto:
                print('Seja bem vindo(a)',Nome)
                return login_correto[0]
            else:
                print('Usuário incorreto')
                
           


def menu(usuario_logado):
    while True:
        print('MENU')
        print('1- Ver Álbum')
        print('2- Minhas figurinhas')
        print('3-Figurinhas faltantes')
        print('4-Pesquisar figurinha')
        print('5-Sair')
        
        opcao = input('Selecione uma opção:')
        if opcao == '1':
            ver_album()
        elif opcao == '2':
            minhas_figurinhas(usuario_logado)
        elif opcao == '3':
            figurinhas_faltantes(usuario_logado)
        elif opcao == '4':
            print('Saindo...')
            break
        
        else:
            print('Opção Inválida')


def ver_album(usu_id):

    sql = """
    SELECT jog_nome, jog_pos, jog_num, selecao.sel_pais
     FROM Jogador
     INNER JOIN Selecao
     ON Jogador(id_selecao) = Selecao(sel_id)
     """ 

    cursorcp.execute(sql)

    resultado = cursorcp.fetchall()
    
    for jogador in resultado:
        print(
            f'Jogador: {jogador[0]} | '
            f'Posição: {jogador[1]} | '
            f'Número: {jogador[2]} | '
            )


def minhas_figurinhas(usu_id):
    
    sql = """
    SELECT 
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

    for fig in resultado:
        print(f"Jogador: {fig[0]} | País: {fig[1]} | Raridade: {fig[2]}")
        
        
def figurinhas_faltantes(usu_id):
    
     sql = """
     SELECT
     Jogador jog_nome
     Selecao.sel_pais
     Figurinha.fig_raridade
     FROM Colecao
     INNER JOIN Jogador ON Figurinha.id_jogador = Jogador.jog_id
     INNER JOIN Selecao ON Jogador.id_selecao = Selecao.sel_id
     
     WHERE Figurinha.fig_id NOT IN(
         SELECT id_figurinha
         FROM Colecao
         WHERE id_usuario = %s
         
   )      
    """