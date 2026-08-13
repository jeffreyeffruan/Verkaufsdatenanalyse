-- ANALYSE DER UMSATZENTWICKLUNG UND DER RELEVANTEN UMSATZTREIBER


-- 1. Übersicht aller importierten Daten
select *
from retail_sales_dataset rsd;


-- 2. Überprüfung, ob der Gesamtumsatz dem Ergebnis der Multiplikation 
-- zwischen dem Verkaufspreis und der Verkaufsmenge entspricht

select *
from retail_sales_dataset rsd
where rsd."Total Amount" != rsd."Quantity" * rsd."Price per Unit";


-- 3. Überprüfung des Verkaufsumsatz bei Altersgruppen

select rsd."Age", 
	   sum(rsd."Total Amount") as "Total Sales"
from retail_sales_dataset rsd
group by rsd."Age" 
order by "Total Sales" desc;


-- 4. Überprüfung des Verkaufsumsatz zwischen beiden Geschlechten

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


-- 6. Zusammenfassung der Analyse
-- a. Die Daten in der Tabelle "Total Amount" sind bereits korrekt.
-- b. Das Alter mit dem höchsten Gesamtumsatz ist 43 Jahre.
-- c. Der höchste Gesamtumsatz wurde am meisten von den weiblichen Kunden erworben.
-- d. Das Produkt Electronics hat den höchsten Umsatz mit 156,905 GE.
--	  Das Produkt Beauty hingegen hat den niedrigsten Umsatz mit 143,515 GE.