import streamlit as st
import pandas as pd
import plotly.express as px
from stramlite.db_connection import create_connection

conn = create_connection()

st.title("Chinook Sales Report")

st.sidebar.header("Фильтры")
min_total = st.sidebar.slider("Минимальная сумма инвойса", 0, 50, 0)
max_total = st.sidebar.slider("Максимальная сумма инвойса", 0, 500, 500)
countries = st.sidebar.multiselect("Выберите страну", ["USA", "Canada", "Germany", "France", "UK"])

if countries:
    country_filter = ', '.join([f"'{c}'" for c in countries])
    query = f"""
    SELECT billing_country, invoice_date, total
    FROM invoice
    WHERE total BETWEEN {min_total} AND {max_total}
    AND billing_country IN ({country_filter})
    ORDER BY invoice_date;
    """
else:
    query = f"""
    SELECT billing_country, invoice_date, total
    FROM invoice
    WHERE total BETWEEN {min_total} AND {max_total}
    ORDER BY invoice_date;
    """

df = pd.read_sql_query(query, conn)

conn.close()

if df.empty:
    st.warning("Нет данных для отображения. Попробуйте изменить фильтры.")
else:
    fig1 = px.line(
        df,
        x="invoice_date",
        y="total",
        title="Динамика продаж",
        labels={"invoice_date": "Дата инвойса", "total": "Сумма продаж"}
    )

    fig2 = px.bar(
        df,
        x="billing_country",
        y="total",
        title="Продажи по странам",
        labels={"billing_country": "Страна", "total": "Сумма продаж"}
    )

    st.plotly_chart(fig1)
    st.plotly_chart(fig2)

    st.dataframe(df)
