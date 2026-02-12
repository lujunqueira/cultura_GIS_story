## 1. Research Design and Spatial Scope
This project examines how cultural participation varies across Brazil’s capital cities and how these differences relate to socioeconomic class and education.

The unit of spatial analysis is the Brazilian capitals (27 cities) represented as point features. The population universe is respondents aged 16 years and older, consistent with the survey design. Comparisons are conducted at two spatial scales:

•	City-level (capital-to-capital comparison)

•	Macro-regional (North, Northeast, Center-West, Southeast, South)

Mapping focuses on percentage-based indicators to ensure comparability across cities with different population sizes.

## 2. Data Source: Cultura nas Capitais (2024)
The analysis uses microdata from the 2024 Cultura nas Capitais survey, conducted by Datafolha for the project organizers, the Federal Government of Brazil, and JLeiva.
Key characteristics:
•	19,500 in-person interviews
•	Conducted February–May 2024
•	Universe: residents aged 16+
•	Coverage: 26 state capitals + Brasília
•	Stratified sampling with quota controls for sex and age
•	Sample weighted by sex, age, race/color, education level, and capital distribution using 2022 Census benchmarks.
•	Margin of error: ±0.7 pp nationally; 2–4 pp at city level

The survey has up to 61 questions, including cultural activities and demographic characteristics.

## 3. Construction of Cultural Participation Intensity Index
Cultural participation intensity was operationalized as a composite index.
From 14 selected cultural activity variables (P1 items), a count variable was constructed:
•	Heavy users: 8–14 activities (last 12 months)
•	Medium users: 4–7
•	Low users: 1–3
•	No users: 0

This approach measures breadth of engagement rather than participation in a single activity.

## 4. Data Modeling and Aggregation
Data modeling was performed in R prior to mapping.
Three analytical tables were produced for Tableau and ArcGIS. Table A stores respondent-level demographics and the participation intensity index; Table B records participation outcomes for each of the 14 activities at the respondent-by-activity level; Table C aggregates weighted survey estimates to the capital-city level for GIS mapping.
All city-level indicators were calculated using survey weights. Percentages were computed from weighted sums, ensuring that each capital’s results reflect the structure of its adult population rather than the raw interview counts. No additional population normalization was required beyond the survey weighting procedure.

#### Table A — Respondent-level (Wide)

Purpose: master analytical file at the individual level; used to compute participation intensity and demographic breakdowns.
Grain: 1 row = 1 respondent.6 Methodology
Core contents
•	Respondent ID (Nquest)
•	Survey weight (Peso) used for all weighted estimates
•	Geography: capital (City) and macro-region (Region)
•	Demographics: at least education level and socioeconomic class (plus other context variables if you keep them)
•	Participation intensity variables:
•	
o	P1_Count = number of activities (out of the 14 selected) reported as done in the last 12 months
o	P1_Count_Label = No / Low / Medium / Heavy user categories based on that count
Why
•	Creating the intensity index and user groups
•	Producing weighted city and region summaries
•	Feeding Table C (aggregated GIS table)




