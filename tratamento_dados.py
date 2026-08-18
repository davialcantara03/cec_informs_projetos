import pandas as pd
import numpy as np

# 1. Carregar as bases de dados
df_cec = pd.read_csv('dataset_cecinforms.csv', sep=';')
df_jogos = pd.read_csv('jogos_cruzeiro.csv')

# 2. Converter colunas de data para datetime
df_cec['data'] = pd.to_datetime(df_cec['data'])
df_jogos['data'] = pd.to_datetime(df_jogos['data'])

# 3. Filtrar apenas os jogos realizados
jogos_realizados = df_jogos[df_jogos['realizado'] == True]

# 4. Validar/Criar coluna de dia de jogo na base do X
datas_dos_jogos = jogos_realizados['data'].unique()
df_cec['teve_jogo'] = np.where(df_cec['data'].isin(datas_dos_jogos), 'Sim', 'Não')

# 5. Cruzar o engajamento da página com as informações da partida
colunas_jogo = ['data', 'competicao', 'mando', 'resultado', 'gols_pro', 'gols_sofridos', 'adversario']

df_final = pd.merge(
    df_cec,
    jogos_realizados[colunas_jogo],
    on='data',
    how='left'
)

# 6. Tratar nulos das colunas do jogo para dias que não houve partida
df_final['resultado'] = df_final['resultado'].fillna('Sem Jogo')
df_final['competicao'] = df_final['competicao'].fillna('Nenhuma')

# 7. Salvar dataset pronto para subir no PostgreSQL
df_final.to_csv('dataset_tratado_final.csv', index=False)

print("Tratamento de dados concluído!")