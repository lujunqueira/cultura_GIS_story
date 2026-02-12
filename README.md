### Methodology

## 1. Research Design and Spatial Scope

This project examines how cultural participation varies across Brazil’s capital cities and how these differences relate to socioeconomic class and education.

The unit of spatial analysis is the Brazilian capitals (27 cities) represented as point features. The population universe is respondents aged 16 years and older, consistent with the survey design. Comparisons are conducted at two spatial scales:

* City-level (capital-to-capital comparison)
* Macro-regional (North, Northeast, Center-West, Southeast, South)

Mapping focuses on percentage-based indicators to ensure comparability across cities with different population sizes.


## 2. Data Source: Cultura nas Capitais (2024)

The analysis uses microdata from the 2024 Cultura nas Capitais survey, conducted by Datafolha for the project organizers, the Federal Government of Brazil, and JLeiva.

**Key characteristics:**

* 19,500 in-person interviews
* Conducted February–May 2024
* Universe: residents aged 16+
* Coverage: 26 state capitals + Brasília
* Stratified sampling with quota controls for sex and age
* Sample weighted by sex, age, race/color, education level, and capital distribution using 2022 Census benchmarks
* Margin of error: ±0.7 pp nationally; 2–4 pp at city level

The survey includes up to 61 questions, including cultural activities and demographic characteristics.


## 3. Construction of Cultural Participation Intensity Index

Cultural participation intensity was operationalized as a composite index.

From 14 selected cultural activity variables (P1 items), a count variable was constructed:

* **Heavy users:** 8–14 activities (last 12 months)
* **Medium users:** 4–7
* **Low users:** 1–3
* **No users:** 0

This approach measures breadth of engagement rather than participation in a single activity.


## 4. Data Modeling and Aggregation

Data modeling was performed in R prior to mapping.

Three analytical tables were produced for Tableau and ArcGIS:

* **Table A** stores respondent-level demographics and the participation intensity index.
* **Table B** records participation outcomes for each of the 14 activities at the respondent-by-activity level.
* **Table C** aggregates weighted survey estimates to the capital-city level for GIS mapping.

All city-level indicators were calculated using survey weights. Percentages were computed from weighted sums, ensuring that each capital’s results reflect the structure of its adult population rather than the raw interview counts. No additional population normalization was required beyond the survey weighting procedure.


### Table A — Respondent-level (Wide)

**Purpose:** master analytical file at the individual level; used to compute participation intensity and demographic breakdowns.

**Grain:** 1 row = 1 respondent.

**Core contents:**

* Respondent ID (Nquest)
* Survey weight (Peso) used for all weighted estimates
* Geography: capital (City) and macro-region (Region)
* Demographics: at least education level and socioeconomic class
* Participation intensity variables:

  * `P1_Count` = number of activities (out of the 14 selected) reported as done in the last 12 months
  * `P1_Count_Label` = No / Low / Medium / Heavy user categories

**Why:**

* Creating the intensity index and user groups
* Producing weighted city and region summaries
* Feeding Table C (aggregated GIS table)


### Table B — Respondent-by-Activity Participation Table (Long)

**Purpose:** analyze participation by each of the 14 cultural activities, not just the total count—mainly for Tableau charts.

**Grain:** 1 row = 1 respondent × 1 activity (P1 item).

**Core contents:**

* Respondent ID
* Weight (Peso)
* City / Region
* Activity identifier (P1 code, e.g., P1A…P1S)
* Activity label (short & full text)
* Response value + label (last 12 months / more than 1 year / never)

**Why:**

* Activity ranking charts
* Regional comparisons by activity

It supports narrative/visualization but is not the GIS join table.



### Table C — City-level Aggregated Table (GIS)

**Purpose:** table joined to the capitals point layer and used for all city maps.

**Grain:** 1 row = 1 capital city.

**Core outputs (weighted estimates):**

* `n_weighted` = sum of weights per city (scaled representation of the adult population structure; contextual only)

**Participation intensity distribution (percent):**

* % No users
* % Low users
* % Medium users
* % Heavy users

**Socioeconomic structure (percent):**

* Class shares (A/B vs C/D/E, depending on grouping)

**Education structure (percent):**

* Shares by education level

**GIS-specific additions (if present):**

* Latitude / Longitude
* Standardized city name field for labeling

**Why:**

* Proportional symbol maps of heavy/no users
* Class and education maps
* City-level pop-ups and legends in StoryMaps


## 5. GIS Workflow

Mapping was conducted entirely in ArcGIS Online.

### Step 1 — Creation of Hosted Feature Layer

* City-level Table C uploaded with latitude/longitude
* Points generated automatically
* Layer saved as primary analytical feature layer

### Step 2 — Geometry Decisions

* Capitals represented as points, not polygons
* State boundaries used only as contextual reference
* Choropleth state mapping rejected because survey data apply only to capital residents

### Step 3 — Data Join and Validation

* Aggregated city table validated for field types and percentage formatting
* Percentages displayed as decimals (e.g., 0.20 for 20%)

### Step 4 — Symbolization

* Proportional symbols used for participation intensity
* Percentages used instead of raw values
* Basemap simplified (Human Geography)
* Label hierarchy controlled by scale (country → capital)

### Step 5 — Map Interpretation

Heavy-user and no-user maps were interpreted comparatively across macro-regions to identify spatial patterns of inequality.



## 6. Analytical Strategy

The analysis follows a structured, layered sequence:

1. Establish geographic and demographic context
2. Present overall participation by activity
3. Construct and map participation intensity
4. Compare extremes of participation
5. Map socioeconomic class distribution
6. Map educational structure (regional and city-level)
7. Compare education and participation patterns

The study is designed as an exploratory spatial analysis. It identifies geographic patterns and structural alignments but does not test causal relationships.



## 7. Limitations

This analysis applies only to residents of Brazil’s 27 capital cities and does not represent cultural participation in smaller cities or rural areas.

The data are cross-sectional (2024) and do not capture changes over time.

The survey measures participation only in the 14 selected activities and does not account for informal, emerging, or unlisted cultural practices.


