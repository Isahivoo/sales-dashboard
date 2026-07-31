# Sales Dashboard

## Projektziel

Ziel dieses Projekts war es, einen vollständigen Business-Intelligence-Workflow umzusetzen, von den Rohdaten bis zum interaktiven Dashboard.
Der Schwerpunkt lag dabei auf der Datenmodellierung in PostgreSQL, der Datenaufbereitung mit SQL und der Entwicklung eines übersichtlichen Dashboards in Power BI.

## Datensatz

Für dieses Projekt wurde die Datei `Ecommerce_data.csv` verwendet.

- **Quelle:** Kaggle
- **Format:** CSV
- **Import:** PostgreSQL
- **Umfang:** ca. 113.000 Datensätze

Die Daten wurden zunächst in PostgreSQL importiert und anschließend in mehrere logisch getrennte Tabellen normalisiert.

## Technischer Ablauf

Nach dem Import wurden die Tabellen über Primär- und Fremdschlüssel miteinander verknüpft.
Anschließend wurde die SQL-View `vw_sales` erstellt, welche als zentrale Datenquelle für Power BI dient.

Die folgende Abbildung zeigt den vollständigen Datenfluss vom CSV-Import bis zum fertigen Dashboard.

![Technischer Workflow](Screenshots/workflow.png)

## Datenmodell

Die Datenbank besteht aus mehreren miteinander verbundenen Tabellen:

- customers
- orders
- order_items
- products
- locations

Durch diese Struktur konnten Redundanzen reduziert und die Daten effizient ausgewertet werden.

## SQL-Beispiel

Für die Nutzung in Power BI wurde die View `vw_sales` erstellt. Sie führt die für die Analyse benötigten Informationen aus den Tabellen `order_items`, `orders`, `customers`, `locations` und `products` zusammen.

```sql
CREATE OR REPLACE VIEW vw_sales AS
SELECT
    oi.order_item_id,
    oi.order_id,
    o.order_date,
    c.customer_id,
    c.first_name,
    c.last_name,
    l.city,
    l.state,
    l.country,
    l.region,
    p.product_name,
    p.category_name,
    oi.order_quantity,
    oi.sales_per_order,
    oi.profit_per_order,
    oi.order_item_discount
FROM order_items oi
JOIN orders o
    ON oi.order_id = o.order_id
JOIN customers c
    ON o.customer_id = c.customer_id
JOIN locations l
    ON c.location_id = l.location_id
JOIN products p
    ON oi.product_id = p.product_id;
```
Die wichtigsten SQL-Skripte befinden sich im Ordner **sql**.

## Dashboard

Das Dashboard bietet eine interaktive Übersicht über die wichtigsten Vertriebskennzahlen.
Enthalten sind unter anderem:

- Gesamtumsatz
- Gesamtgewinn
- Bestellungen
- Kunden
- Gewinnmarge
- Durchschnittlicher Bestellwert
- Umsatz nach Kategorie
- Umsatz nach Region
- Umsatzentwicklung
- Top 5 Kunden
- Top 5 Produkte

Zusätzlich können alle Auswertungen nach Kategorie, Region und Zeitraum gefiltert werden.

Die Power-BI-Datei befindet sich im Ordner **powerbi**.

### Dashboard-Übersicht

Die folgende Ansicht zeigt die zentralen KPIs, die Umsatz- und Gewinnentwicklung sowie die Auswertungen nach Kategorie, Region, Kunden und Produkten.

![Übersicht des Vertriebsdashboards](Screenshots/dashboard-overview.png)

### Interaktive Filter

Die zweite Ansicht zeigt die Filtermöglichkeiten nach Kategorie, Region und Zeitraum. Alle Kennzahlen und Diagramme reagieren automatisch auf die gewählte Filterung.

![Interaktive Filter im Vertriebsdashboard](Screenshots/dashboard-filter.png)

## DAX Measures

Für die Kennzahlen im Dashboard wurden eigene DAX Measures erstellt.

```DAX
Gesamtumsatz =
SUM('public vw_sales'[sales_per_order])
```

```DAX
Gesamtgewinn =
SUM('public vw_sales'[profit_per_order])
```

```DAX
Bestellungen =
DISTINCTCOUNT('public vw_sales'[order_id])
```

```DAX
Kunden =
DISTINCTCOUNT('public vw_sales'[customer_id])
```

```DAX
Durchschnittlicher Bestellwert =
DIVIDE([Gesamtumsatz], [Bestellungen])
```

```DAX
Gewinnmarge % =
DIVIDE([Gesamtgewinn], [Gesamtumsatz])
```

## Verwendete Technologien

- PostgreSQL
- SQL
- Power BI
- DAX
- Git und GitHub

## Erkenntnisse aus der Datenanalyse

- Office Supplies erzielte den höchsten Umsatz.
- Die Region West generierte den größten Umsatz.
- Der durchschnittliche Bestellwert lag bei rund 204 €.
- Die Gewinnmarge betrug ca. 11 %.

## Praktische Erfahrungen

Während dieses Projekts konnte ich praktische Erfahrungen in folgenden Bereichen sammeln:

- Datenmodellierung in PostgreSQL
- Arbeiten mit SQL Views
- Datenaufbereitung mit SQL
- Entwicklung interaktiver Dashboards in Power BI
- Erstellung von DAX Measures
- Visualisierung geschäftsrelevanter Kennzahlen

