-- ANALYSE DES VERKAUFSUMSATZES NACH KUNDEN- UND PRODUKTMERKMALEN


-- 1. Übersicht aller importierten Daten
select *
from retail_sales_dataset rsd;


-- 2. Überprüfung, ob der Gesamtumsatz dem Ergebnis der Multiplikation 
-- zwischen dem Verkaufspreis und der Verkaufsmenge entspricht

select *
from retail_sales_dataset rsd
where rsd."Total Amount" != rsd."Quantity" * rsd."Price per Unit";


-- 3. Analyse des Verkaufsumsatzes nach Alter

select rsd."Age", 
	   sum(rsd."Total Amount") as "Total Sales"
from retail_sales_dataset rsd
group by rsd."Age" 
order by "Total Sales" desc;


-- 4. Vergleich des Verkaufsumsatzes zwischen den Geschlechtern

select rsd."Gender",
	   sum(rsd."Total Amount") as "Total Sales"
from retail_sales_dataset rsd 
group by rsd."Gender";


-- 5. Festlegung der höchsten und niedrigsten Umsatz der 3 Produktkategorien

select rsd."Product Category",
	   sum(rsd."Total Amount") as "Total Sales"
from retail_sales_dataset rsd 	
group by rsd."Product Category" 
order by "Total Sales" desc
limit 1;

select rsd."Product Category",
	   sum(rsd."Total Amount") as "Total Sales"
from retail_sales_dataset rsd 	
group by rsd."Product Category" 
order by "Total Sales" asc
limit 1;


-- 6. Kategorisierung der Kunden nach Altersgruppen mit CASE WHEN

select
    case
        when rsd."Age" < 30 then 'Unter 30'
        when rsd."Age" between 30 and 49 then '30-49'
        else '50+'
    end as "Altersgruppe",
    sum(rsd."Total Amount") as "Total Sales"
from retail_sales_dataset rsd
group by "Altersgruppe"
order by "Total Sales" desc;


-- 7. Produktkategorien mit einem Gesamtumsatz über 150.000 GE
-- Anwendung von HAVING

select
    rsd."Product Category",
    sum(rsd."Total Amount") as "Total Sales"
from retail_sales_dataset rsd
group by rsd."Product Category"
having sum(rsd."Total Amount") > 150000
order by "Total Sales" desc;


-- 8. Umsatz je Produktkategorie mit CTE

with category_sales as (
    select
        rsd."Product Category",
        sum(rsd."Total Amount") as "Total Sales"
    from retail_sales_dataset rsd
    group by rsd."Product Category"
)

select *
from category_sales
order by "Total Sales" desc;


-- 9. Ranking der Produktkategorien nach Gesamtumsatz

with category_sales as (
    select
        rsd."Product Category",
        sum(rsd."Total Amount") as "Total Sales"
    from retail_sales_dataset rsd
    group by rsd."Product Category"
)

select
    "Product Category",
    "Total Sales",
    rank() over (
        order by "Total Sales" desc
    ) as "Sales Rank"
from category_sales;




-- 10. Zusammenfassung der Analyse
-- a. Die Spalte "Total Amount" stimmt mit der Berechnung aus Verkaufsmenge und Stückpreis überein.
-- b. Beim Vergleich nach Alter wurde der höchste Gesamtumsatz bei den 43-jährigen Kunden festgestellt.
-- c. Insgesamt ist der Umsatz der weiblichen Kunden höher als der der männlichen Kunden.
-- d. Von den drei Produktkategorien erzielt Electronics mit 156.905 GE den höchsten Gesamtumsatz.
-- e. Beauty hat mit 143.915 GE den niedrigsten Gesamtumsatz.
-- f. Durch die Einteilung in Altersgruppen lässt sich der Umsatz zusätzlich nach größeren Kundengruppen vergleichen.
-- g. Mit HAVING wurden nur Produktkategorien berücksichtigt, deren Gesamtumsatz über 150.000 GE liegt.
-- h. Die CTE wurde genutzt, um den Umsatz je Produktkategorie zuerst als Zwischenergebnis zu berechnen.
-- i. Mit RANK() wurden die Produktkategorien anschließend nach ihrem Gesamtumsatz geordnet.