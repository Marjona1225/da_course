
import psycopg2

# Настройка подключения к базе данных
# conn = psycopg2.connect(
#     dbname="postgres",
#     user="postgres",
#     password="2501",
#     host="localhost",
#     port="5432"
# )

# cursor = conn.cursor()

# Подключаемся к базе данных
# conn = psycopg2.connect(
#     host="localhost",  
#     port=5432,  
#     user="postgres",  
#     password=2501,  
#     dbname="postgres"  
# )
# cursor = conn.cursor()


# import psycopg2

# conn = psycopg2.connect(
#     dbname="postgres",
#     user="postgres",
#     password=2501,
#     host="localhost",
#     port=5432
# )
# cursor = conn.cursor()

# # Подключение к базе данных через SQLAlchemy
# def create_connection():
#     engine = create_engine(
#         "postgresql+psycopg2://postgres:2501@localhost:5432/postgres"
#     )
#     return engine



import psycopg2

# def create_connection():
#     try:
#         conn = psycopg2.connect(
#             dbname="postgres",
#             user="postgres",
#             password=2501,
#             host="localhost",
#             port=5432
#         )
#         return conn
#     except psycopg2.Error as e:
#         print("Ошибка при подключении к базе данных:", e)
#         return None

# Настройка подключения с SQLAlchemy
engine = create_engine('postgresql+psycopg2://postgres:2501@localhost:5432/postgres')