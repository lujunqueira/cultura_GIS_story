# ============================================================
# Cultura nas Capitais – Mother script for A, B, C tables
# ============================================================

library(tidyverse)

#--------------------------------------------------------------
# 0. Read raw survey file
#--------------------------------------------------------------
raw <- readr::read_csv("PM5011_TOTAL_8.csv", show_col_types = FALSE)


#--------------------------------------------------------------
# 1. Look-up table: City -> State
#--------------------------------------------------------------
city_state <- tribble(
  ~City,              ~State,
  "Rio Branco",       "Acre",
  "Macapá",           "Amapá",
  "Manaus",           "Amazonas",
  "Belém",            "Pará",
  "Boa Vista",        "Roraima",
  "Palmas",           "Tocantins",
  "Aracaju",          "Sergipe",
  "Maceió",           "Alagoas",
  "Salvador",         "Bahia",
  "Fortaleza",        "Ceará",
  "São Luís",         "Maranhão",
  "João Pessoa",      "Paraíba",
  "Recife",           "Pernambuco",
  "Teresina",         "Piauí",
  "Natal",            "Rio Grande do Norte",
  "Brasília",         "Distrito Federal",
  "Goiânia",          "Goiás",
  "Cuiabá",           "Mato Grosso",
  "Campo Grande",     "Mato Grosso do Sul",
  "Vitória",          "Espírito Santo",
  "Belo Horizonte",   "Minas Gerais",
  "Rio de Janeiro",   "Rio de Janeiro",
  "São Paulo",        "São Paulo",
  "Curitiba",         "Paraná",
  "Florianópolis",    "Santa Catarina",
  "Porto Alegre",     "Rio Grande do Sul",
  "Macapá",           "Amapá",
  "Porto Velho",      "Rondônia"
)

#--------------------------------------------------------------
# 2. Demographic re codes
#--------------------------------------------------------------

# City (from Capital)
city_labels <- c(
  `4300`="Aracaju", `2300`="Belém", `700`="Belo Horizonte",
  `5700`="Boa Vista", `2900`="Brasília", `3300`="Campo Grande",
  `3500`="Cuiabá", `1300`="Curitiba", `3100`="Florianópolis",
  `2100`="Fortaleza", `2700`="Goiânia", `4100`="João Pessoa",
  `5100`="Macapá", `5300`="Maceió", `4900`="Manaus",
  `4500`="Natal", `5900`="Palmas", `1100`="Porto Alegre",
  `5500`="Porto Velho", `1900`="Recife", `4700`="Rio Branco",
  `500`="Rio de Janeiro", `1500`="Salvador", `3900`="São Luís",
  `100`="São Paulo", `3700`="Teresina", `2500`="Vitória"
)

region_labels <- c(
  `1`="Sudeste", `2`="Sul", `3`="Nordeste",
  `4`="Centro-Oeste", `5`="Norte"
)

age_labels <- c(
  `1`="16 a 24", `2`="25 a 34", `3`="35 a 44",
  `4`="45 a 59", `5`="60 +"
)

edu_labels <- c(
  `1`="Elementary", `2`="Secondary", `3`="Higher Education"
)

class_labels <- c(
  `1`="A", `2`="B1", `3`="B2", `4`="C1", `5`="C2", `6`="D/E"
)

income_labels <- c(
  `9` ="Up to R$ 1,412.00",
  `1` ="From R$ 1,413.00 to R$ 2,824.00",
  `2` ="From R$ 2,825.00 to R$ 4,236.00",
  `3` ="From R$ 4,237.00 to R$ 7,060.00",
  `4` ="From R$ 7,061.00 to R$ 14,120.00",
  `5` ="From R$ 14,121.00 to R$ 28,240.00",
  `6` ="From R$ 28,241.00 to R$ 70,060.00",
  `7` ="R$ 70,061.00 or more",
  `99`="Don’t know",
  `97`="Refused to answer"
)

internet_labels <- c(
  `1`="Always connected",
  `2`="Almost always connected",
  `3`="Sometimes connected",
  `4`="Sometimes connected",
  `96`="Never connected"
)

ethnicity_labels <- c(
  `1`="White", `2`="Black", `3`="Mixed",
  `4`="Asian", `5`="Indigenous"
)

marital_labels <- c(
  `1`="Married", `2`="Single", `3`="Widowed", `4`="Separated"
)

sexual_labels <- c(
  `1`="LGBTQIAPN+", `2`="LGBTQIAPN+", `3`="LGBTQIAPN+",
  `4`="LGBTQIAPN+", `5`="Heterosexual", `6`="LGBTQIAPN+",
  `7`="Other", `8`="LGBTQIAPN+",
  `94`="Other", `96`="Other", `97`="Other",
  `98`="Other", `99`="Other"
)

religion_labels <- c(
  # Don't know / did not answer
  `97`="Other", `99`="Other",
  # Blank
  `98`=NA_character_,
  # Atheist / No religion
  `96`="Atheist / No religion",
  `110`="Atheist / No religion",
  `112`="Atheist / No religion",
  # Undefined
  `111`="Undefined", `114`="Undefined",
  `115`="Undefined", `116`="Undefined",
  # Other explicit codes
  `117`="Other", `2`="Other", `7`="Other", `8`="Other",
  `9`="Other", `10`="Other", `11`="Other", `14`="Other",
  `15`="Other", `16`="Other", `17`="Other", `18`="Other",
  `19`="Other", `20`="Other", `21`="Other", `22`="Other",
  `23`="Other", `24`="Other", `25`="Other", `27`="Other",
  `28`="Other", `29`="Other", `30`="Other", `32`="Other",
  `33`="Other",
  # Catholic
  `4`="Catholic",
  # Spiritist
  `5`="Spiritist | Kardecist",
  # Afro-Brazilian
  `3`="Afro-Brazilian", `12`="Afro-Brazilian",
  `26`="Afro-Brazilian", `31`="Afro-Brazilian",
  # Evangelical (collapsed)
  `1`="Evangelical", `6`="Evangelical", `13`="Evangelical",
  `60`="Evangelical", `61`="Evangelical", `62`="Evangelical",
  `63`="Evangelical", `64`="Evangelical", `65`="Evangelical",
  `66`="Evangelical", `67`="Evangelical", `68`="Evangelical",
  `69`="Evangelical", `70`="Evangelical", `71`="Evangelical",
  `72`="Evangelical", `73`="Evangelical", `74`="Evangelical",
  `75`="Evangelical", `76`="Evangelical", `77`="Evangelical",
  `78`="Evangelical", `79`="Evangelical",
  `113`="Evangelical", `981`="Evangelical"
)

demog_core <- raw |>
  mutate(
    City                = recode(as.character(Capital), !!!city_labels, .default = NA_character_),
    Region              = recode(as.character(Regiao),  !!!region_labels, .default = NA_character_),
    Age_Group           = recode(as.character(Idade),   !!!age_labels, .default = NA_character_),
    Highest_qualification = recode(as.character(Escola1), !!!edu_labels, .default = NA_character_),
    Socioeconomic_group = recode(as.character(Rclasse2), !!!class_labels, .default = NA_character_),
    Income_group        = recode(as.character(Rendaf),  !!!income_labels, .default = NA_character_),
    Internet_use        = recode(as.character(P18),     !!!internet_labels, .default = NA_character_),
    Ethnicity           = recode(as.character(Cor),     !!!ethnicity_labels, .default = NA_character_),
    Marital_status      = recode(as.character(Estcivil),!!!marital_labels, .default = NA_character_),
    Sexual_orientation  = recode(as.character(P55),     !!!sexual_labels, .default = NA_character_),
    .P54A               = as.integer(P54A),
    .P54B               = as.integer(P54B),
    Gender = case_when(
      .P54A == 1 ~ "Man",
      .P54A == 2 ~ "Woman",
      .P54A %in% c(3, 4) & .P54B == 1 ~ "Man",
      .P54A %in% c(3, 4) & .P54B == 3 ~ "Woman",
      .P54A %in% c(3, 4) & .P54B %in% c(2, 4, 5, 96, 99) ~ "Other responses",
      TRUE ~ "Other responses"
    ),
    Children = case_when(
      as.integer(Nfilhos) == 96 ~ "No children",
      TRUE ~ "Children"
    ),
    Religion = recode(as.integer(Religiao1), !!!religion_labels, .default = NA_character_)
  ) |>
  select(
    Nquest,
    Peso,
    City,
    Region,
    Age_Group,
    Highest_qualification,
    Socioeconomic_group,
    Income_group,
    Internet_use,
    Ethnicity,
    Marital_status,
    Sexual_orientation,
    Religion,
    Gender,
    Children
  ) |>
  left_join(city_state, by = "City")  # adds State

#--------------------------------------------------------------
# 3. P1 count (numeric 0–14) + label
#    Using the same 14 activities (exclude E, F, K, O, P)
#--------------------------------------------------------------
p1_all  <- paste0("P1", LETTERS[1:19])     # P1A..P1S
p1_drop <- c("P1E","P1F","P1K","P1O","P1P")
p1_keep <- setdiff(p1_all, p1_drop)        # 14 items kept

p1_count <- raw |>
  transmute(
    Nquest,
    across(all_of(p1_keep), ~ suppressWarnings(as.integer(.)))
  ) |>
  rowwise() |>
  mutate(P1_Count = sum(c_across(all_of(p1_keep)) == 1, na.rm = TRUE)) |>
  ungroup() |>
  mutate(
    P1_Count_Label = case_when(
      is.na(P1_Count)          ~ NA_character_,
      P1_Count == 0            ~ "No user (0)",
      P1_Count >= 1 & P1_Count <= 3  ~ "Low user (3-1)",
      P1_Count >= 4 & P1_Count <= 7  ~ "Medium user (7-4)",
      P1_Count >= 8            ~ "Heavy user (14-8)"
    )
  ) |>
  select(Nquest, P1_Count, P1_Count_Label)

#--------------------------------------------------------------
# 4. Table A: a_demog_p1_wide  (one row per respondent)
#--------------------------------------------------------------
a_demog_p1_wide <- demog_core |>
  left_join(p1_count, by = "Nquest") |>
  rename(
    Weight           = Peso,
    `Age Group`      = Age_Group,
    `Education Level`= Highest_qualification,
    `Socioeconomic Class` = Socioeconomic_group,
    `Income Group`   = Income_group,
    `Internet Access`= Internet_use,
    `Marital Status` = Marital_status,
    `Sexual Orientation` = Sexual_orientation,
    `P1 Count`       = P1_Count,
    `P1 Count Label` = P1_Count_Label
  ) |>
  # order columns exactly as you specified
  select(
    Nquest,
    Weight,
    City,
    State,
    Region,
    `Age Group`,
    `Education Level`,
    `Socioeconomic Class`,
    `Income Group`,
    `Internet Access`,
    Ethnicity,
    `Marital Status`,
    `Sexual Orientation`,
    Religion,
    Gender,
    Children,
    `P1 Count`,
    `P1 Count Label`
  )

readr::write_csv(a_demog_p1_wide, "a_demog_p1_wide.csv")

#--------------------------------------------------------------
# 5. P1 long table with question + response labels
#    (only 14 kept items, same subset as P1_Count)
#--------------------------------------------------------------
# Question labels (short + full)
p1_labels <- tribble(
  ~P1_Variable, ~`P1 Question Short`, ~`P1 Question Full`,
  "P1A", "Libraries",        "Did you go to libraries?",
  "P1B", "Cinema",           "Did you go to the cinema?",
  "P1C", "Circus",           "Did you go to the circus or attend circus performances?",
  "P1D", "Museums",          "Did you go to museums or exhibitions of art or historical nature?",
  # E, F dropped
  "P1G", "Theater",          "Did you go to theater performances (adult, children’s, stand-up, or musicals)?",
  "P1H", "Dance",            "Did you go to dance shows or dance performances?",
  "P1I", "Book fairs",       "Did you go to book fairs or literary festivals?",
  "P1J", "Music shows",      "Did you go to music shows or musical performances?",
  # K dropped
  "P1L", "Concerts",         "Did you go to classical or erudite music concerts, or opera?",
  "P1M", "Poetry slams",     "Did you go to poetry, literary or musical gatherings, or poetry slams/battles?",
  "P1N", "Folk festivals",   "Did you go to popular, traditional, or folk festivals?",
  # O, P dropped
  "P1Q", "Read books",       "Did you read books?",
  "P1R", "Games",            "Did you play electronic games on video game consoles, computers, cell phones, or tablets?",
  "P1S", "Historical sites", "Did you visit historical sites (not for religious purposes)?"
)

response_labels <- c(
  `1` = "Last 12 months",
  `2` = "More than 1 year ago",
  `3` = "Never"
)

p1_long <- raw |>
  select(Nquest, all_of(p1_keep)) |>
  pivot_longer(
    cols      = starts_with("P1"),
    names_to  = "P1_Variable",
    values_to = "P1_Response_Code"
  ) |>
  mutate(
    P1_Response_Code  = as.integer(P1_Response_Code),
    `P1 Response Label` = unname(response_labels[as.character(P1_Response_Code)])
  ) |>
  left_join(p1_labels, by = "P1_Variable")

#--------------------------------------------------------------
# 6. Table B: b_demog_p1_long
#    One row per respondent × P1_Variable
#--------------------------------------------------------------
b_demog_p1_long <- a_demog_p1_wide |>
  select(
    Nquest,
    Weight,
    City,
    State,
    Region,
    `P1 Count`,
    `P1 Count Label`
  ) |>
  left_join(p1_long, by = "Nquest") |>
  # reorder/rename to match your header exactly
  transmute(
    Nquest,
    Weight,
    City,
    State,
    Region,
    `P1 Count`,
    `P1 Count Label`,
    `P1 Variable`        = P1_Variable,
    `P1 Question Full`   = `P1 Question Full`,
    `P1 Question Short`  = `P1 Question Short`,
    `P1 Response Code`   = P1_Response_Code,
    `P1 Response Label`  = `P1 Response Label`
  )

readr::write_csv(b_demog_p1_long, "b_demog_p1_long.csv")

#--------------------------------------------------------------
# 7. Table C: c_demog_p1_city (wide, GIS-ready)
#    One row per city with weighted shares that sum to 1
#--------------------------------------------------------------
c_demog_p1_city <- a_demog_p1_wide |>
  group_by(City, State, Region) |>
  summarise(
    # total weighted "mass" for this city
    n_weighted = sum(Weight, na.rm = TRUE),
    
    # participation profile (should sum to ~1 per city)
    `No user (0)`       = sum(Weight[`P1 Count Label` == "No user (0)"],        na.rm = TRUE) / n_weighted,
    `Low user (3-1)`    = sum(Weight[`P1 Count Label` == "Low user (3-1)"],     na.rm = TRUE) / n_weighted,
    `Medium user (7-4)` = sum(Weight[`P1 Count Label` == "Medium user (7-4)"],  na.rm = TRUE) / n_weighted,
    `Heavy user (14-8)` = sum(Weight[`P1 Count Label` == "Heavy user (14-8)"],  na.rm = TRUE) / n_weighted,
    
    # socioeconomic structure (class shares; should sum to ~1 per city)
    `Class A` = sum(Weight[`Socioeconomic Class` %in% c("A")], na.rm = TRUE) / n_weighted,
    `Class B` = sum(Weight[`Socioeconomic Class` %in% c("B1", "B2")], na.rm = TRUE) / n_weighted,
    `Class C`   = sum(Weight[`Socioeconomic Class` %in% c("C1", "C2")],      na.rm = TRUE) / n_weighted,
    `Class D/E`     = sum(Weight[`Socioeconomic Class` == "D/E"],                na.rm = TRUE) / n_weighted,
     
    # educational structure (education level shares; should sum to ~1 per city)
    `Elementary`        = sum(Weight[`Education Level` == "Elementary"],        na.rm = TRUE) / n_weighted,
    `Secondary`         = sum(Weight[`Education Level` == "Secondary"],         na.rm = TRUE) / n_weighted,
    `Higher Education`  = sum(Weight[`Education Level` == "Higher Education"],  na.rm = TRUE) / n_weighted,
    
    .groups = "drop"
  )

readr::write_csv(c_demog_p1_city, "c_demog_p1_city.csv")

# End of script
