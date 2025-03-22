import streamlit as st
import pandas as pd
import psycopg2
from psycopg2.extras import RealDictCursor
import plotly.express as px
import datetime

from db_connection import create_connection

@st.cache_data
def load_data(query, params):
   
    conn = create_connection()
    if conn is None:
        st.error("Ошибка подключения к базе данных.")
        return pd.DataFrame()
    
    try:
        with conn.cursor(cursor_factory=RealDictCursor) as cursor:
            cursor.execute(query, params)
            data = cursor.fetchall()
        return pd.DataFrame(data)
    except Exception as e:
        st.error(f"Ошибка выполнения запроса: {e}")
        return pd.DataFrame()
    finally:
        conn.close()

st.sidebar.header("Фильтры")

today = datetime.date.today()
default_start = today - datetime.timedelta(days=30)

start_date = st.sidebar.date_input("Начальная дата", default_start)
end_date = st.sidebar.date_input("Конечная дата", today)

start_date_str = start_date.strftime('%Y-%m-%d')
end_date_str = end_date.strftime('%Y-%m-%d')

invoice_query = """
SELECT invoice_date::DATE AS invoice_date, SUM(total) as sales
FROM invoice
WHERE invoice_date BETWEEN %s AND %s
GROUP BY invoice_date::DATE
ORDER BY invoice_date::DATE;
"""

genre_query = """
SELECT g.name as genre, SUM(il.quantity * il.unit_price) as total_sales
FROM invoice_line il
JOIN track t ON il.track_id = t.track_id
JOIN genre g ON t.genre_id = g.genre_id
JOIN invoice i ON il.invoice_id = i.invoice_id
WHERE i.invoice_date BETWEEN %s AND %s
GROUP BY g.name
ORDER BY total_sales DESC;
"""

st.title("Дашборд продаж")

with st.spinner("Загрузка данных..."):
    invoice_data = load_data(invoice_query, (start_date_str, end_date_str))
    genre_data = load_data(genre_query, (start_date_str, end_date_str))

st.subheader("Сумма продаж по дате инвойса")
if not invoice_data.empty:
    line_chart = px.line(invoice_data, x='invoice_date', y='sales', title="Сумма продаж")
    st.plotly_chart(line_chart)
else:
    st.warning("Данные отсутствуют. Проверьте фильтры.")

st.subheader("Сумма инвойсов по жанрам")
if not genre_data.empty:
    bar_chart = px.bar(genre_data, x='genre', y='total_sales', title="Разбивка по жанрам")
    st.plotly_chart(bar_chart)
else:
    st.warning("Данные отсутствуют. Проверьте фильтры.")
