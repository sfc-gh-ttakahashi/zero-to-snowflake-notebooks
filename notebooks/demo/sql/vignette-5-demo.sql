USE DATABASE tb_101;
USE WAREHOUSE tb_de_wh;
-- アナリストロールに切り替え
USE ROLE tb_analyst;
/*
    日次気象履歴ビューを使用して、Benは2022年2月のハンブルクの平均日次気象温度を
    見つけて、線グラフとして可視化したいと考えています。

    結果ペインで「チャート」をクリックして結果をグラフィカルに可視化します。チャートビューで、
    「チャートタイプ」と表示されている左側のセクションで、以下の設定を構成してください：
    
        チャートタイプ：線グラフ | X軸：DATE_VALID_STD | Y軸：AVERAGE_TEMP_F
*/
SELECT
    dw.country_desc,
    dw.city_name,
    dw.date_valid_std,
    AVG(dw.avg_temperature_air_2m_f) AS average_temp_f
FROM harmonized.daily_weather_v dw
WHERE dw.country_desc = 'Germany'
    AND dw.city_name = 'Hamburg'
    AND YEAR(date_valid_std) = 2022
    AND MONTH(date_valid_std) = 2 -- 2月
GROUP BY dw.country_desc, dw.city_name, dw.date_valid_std
ORDER BY dw.date_valid_std DESC;