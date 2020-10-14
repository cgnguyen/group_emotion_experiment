# Script: PopEmo
# Last updated: 10/12/2020

#install.packages(c("pillar", "haven", "expss", "tidyverse", "corrr", "psych"))
library(pillar)
library(haven)
library(expss)
library(tidyverse)
library(corrr)
library(psych)


df <- read_sav("data_project_800804_2020_05_19(1).sav")

df<-df[(df$dispcode == 31 & 32),]

#delete unuseful columns
df[ ,c("tester", "external_lfdn", "lastpage","quality", "c_0002", "p_0001", "c_0003",
       "c_0004", "browser", "referer", "device_type", "page_history", "hflip",
       "vflip", "output_mode", "javascript", "flash", "session_id", "language",
       "cleaned", "ats", "date_of_last_access", "date_of_first_mail","datetime", "quota",
       "quota_assignment", "rts5396166","rts5396169", "rts5396230", "rts5396253", "rts5396558",
       "rts5396559", "rts5397943", "rts5398020", "rts5398022", "rts5400066", "rts5400107",
       "rts5400116", "rts5400145", "rts5417987", "rts5417988", "rts5417989",
       "rts5417990","rts5421535", "rts5491816", "rts5492630"
)] <- list(NULL)


#rename columns
df <- df %>% rename(treatment = c_0001,
                    geschlecht = v_6,
                    alter = v_108,
                    schulabschluss =v_7,
                    ausbildung = v_8,
                    links_rechts = v_21,
                    sonntagsfrage = v_22,
                    sonntagsfrage_sonstige = v_24,
                    sonntagsfrage_muss = v_27,
                    sonntagsfrage_muss_sonstige = v_28,
                    pt_eins_teilen = v_83,
                    pt_eins_nachvollziehen = v_84,
                    pt_angst_teilen = v_93,
                    pt_angst_nachvollziehen = v_94,
                    pt_wut_teilen = v_36,
                    pt_wut_nachvollziehen = v_38,
                    pretest_comment_post_treatment = v_103,
                    ot_ci_vertrauen = v_49,
                    ot_ci_ausnutzen = v_50,
                    ot_ci_tun_was_sie_sagen = v_51,
                    ot_ci_gut_zurecht_kommen = v_99,
                    ot_ci_zusammenarbeiten = v_54,
                    eel_act_eigene_emotionen_angst = v_55,
                    eel_act_eigene_emotionen_wut = v_56,
                    eel_act_eigene_emotionen_ekel = v_57,
                    eel_act_eigene_emotionen_scham = v_58,
                    eel_act_eigene_emotionen_verachtung = v_59,
                    eel_act_eigene_emotionen_stolz = v_60,
                    eel_act_eigene_emotionen_freude = v_61,
                    eel_act_eigene_emotionen_hoffnung = v_62,
                    eel_act_eigene_emotionen_trauer = v_63,
                    eel_act_act_unangenehm = v_64,
                    eel_act_act_klein = v_65,
                    eel_act_act_langsam = v_66,
                    scm_sympatisch = v_40,
                    scm_warmherzig = v_41,
                    scm_gutmuetig = v_42,
                    bt_kontakt_haeufigkeit = v_69,
                    bt_kontakt_angenehm = v_70,
                    bt_approach_konfrontieren = v_43,
                    bt_approach_entgegenstellen = v_44,
                    bt_approach_avoidance = v_45,
                    bt_avoidance_meiden = v_46,
                    bt_avoidance_zu_tun_haben = v_47,
                    bt_avoidance_abstand_halten = v_48,
                    haushalteinkommen = v_10,
                    wohnort = v_12,
                    deutsch = v_14,
                    deutsch_nicht = v_15,
                    pretest_comment_post_survey = dupl1_v_100
                    )


# "weiss ich nicht" oder "sonstige" als NA
df$sonntagsfrage[df$sonntagsfrage == 8] <- NA
df$sonntagsfrage_muss[df$sonntagsfrage_muss == 7] <- NA

df$pt_eins_teilen[df$pt_eins_teilen == 8] <- NA
df$pt_angst_teilen[df$pt_angst_teilen == 8] <- NA
df$pt_angst_nachvollziehen[df$pt_angst_nachvollziehen == 8] <- NA
df$pt_wut_teilen[df$pt_wut_teilen == 8] <- NA
df$pt_wut_nachvollziehen[df$pt_wut_nachvollziehen == 8] <- NA

df$ot_ci_vertrauen[df$ot_ci_vertrauen == 8] <- NA
df$ot_ci_ausnutzen[df$ot_ci_ausnutzen == 8] <- NA
df$ot_ci_tun_was_sie_sagen[df$ot_ci_tun_was_sie_sagen == 8] <- NA
df$ot_ci_gut_zurecht_kommen[df$ot_ci_gut_zurecht_kommen == 8] <- NA
df$ot_ci_zusammenarbeiten[df$ot_ci_zusammenarbeiten == 8] <- NA

df$eel_act_eigene_emotionen_angst[df$eel_act_eigene_emotionen_angst == 8] <- NA
df$eel_act_eigene_emotionen_wut[df$eel_act_eigene_emotionen_wut == 8] <- NA
df$eel_act_eigene_emotionen_ekel[df$eel_act_eigene_emotionen_ekel == 8] <- NA
df$eel_act_eigene_emotionen_scham[df$eel_act_eigene_emotionen_scham == 8] <- NA
df$eel_act_eigene_emotionen_verachtung[df$eel_act_eigene_emotionen_verachtung == 8] <- NA
df$eel_act_eigene_emotionen_stolz[df$eel_act_eigene_emotionen_stolz == 8] <- NA
df$eel_act_eigene_emotionen_freude[df$eel_act_eigene_emotionen_freude == 8] <- NA
df$eel_act_eigene_emotionen_hoffnung[df$eel_act_eigene_emotionen_hoffnung == 8] <- NA
df$eel_act_eigene_emotionen_trauer[df$eel_act_eigene_emotionen_trauer == 8] <- NA

df$scm_sympatisch[df$scm_sympatisch == 8] <- NA
df$scm_warmherzig[df$scm_warmherzig == 8] <- NA
df$scm_gutmuetig[df$scm_gutmuetig == 8] <- NA

df$bt_kontakt_haeufigkeit[df$bt_kontakt_haeufigkeit == 8] <- NA
df$bt_kontakt_angenehm[df$bt_kontakt_angenehm == 8] <- NA
df$bt_approach_konfrontieren[df$bt_approach_konfrontieren == 8] <- NA
df$bt_approach_entgegenstellen[df$bt_approach_entgegenstellen == 8] <- NA
df$bt_approach_avoidance[df$bt_approach_avoidance == 8] <- NA
df$bt_avoidance_meiden[df$bt_avoidance_meiden  == 8] <- NA
df$bt_avoidance_zu_tun_haben[df$bt_avoidance_zu_tun_haben == 8] <- NA
df$bt_avoidance_abstand_halten[df$bt_avoidance_abstand_halten == 8] <- NA


#Factor variables

## treatment
df = apply_labels(df,
                  treatment = c("Angst - Zuwanderung" = 1,
                                "Wut - Zuwanderung" = 2,
                                "Angst - Eliten" = 3,
                                "Wut - Eliten" = 4))
df$treatment <- as.factor(df$treatment)

# Generate emotion and topic variable (separate treatment vars.)

df$emotion<-NA
df$thema<-NA
levels(df$treatment)

df$emotion[df$treatment=="Wut - Zuwanderung" | df$treatment=="Wut - Eliten" ] <- "wut"
df$emotion[df$treatment=="Angst - Zuwanderung" | df$treatment=="Angst - Eliten"] <- "angst"
df$emotion

df$thema[df$treatment=="Wut - Zuwanderung" | df$treatment=="Angst - Zuwanderung" ] <- "migration"
df$thema[df$treatment=="Wut - Eliten" | df$treatment=="Angst - Eliten"] <- "eliten"
df$thema


df = apply_labels(df,
                  ausbildung = c("Beruflich" = 1,
                                "Teilfacharbeiterabschluss" = 2,
                                "Gewerbliche oder landwirtschaftliche Lehre" = 3,
                                "Kaufmaennische Lehre" = 4,
                                "Fachschulabschluss" = 5,
                                "Berufsfachschulabschluss" = 6,
                                "Meister-, Techniker- oder gleichwertiger Abschluss" = 7,
                                "Fachhochschulabschluss" = 8,
                                "Hochschulabschluss" = 9))
df$ausbildung <- as.factor(df$ausbildung)

df = apply_labels(df,
                  schulabschluss = c("Schule beendet ohne Abschluss" = 1,
                                 "Volks-/ Hauptschulabschluss bzw. POS 8.oder 9. Klasse" = 2,
                                 "Mittlere Reife, Realschulabschluss bzw. POS 10. Klasse" = 3,
                                 "Fachhochschulreife" = 4,
                                 "Abitur" = 5,
                                 "Berufsfachschulabschluss" = 6,
                                 "Bin Schueler, habe noch keinen Schulabschluss" = 7))
df$schulabschluss <- as.factor(df$schulabschluss)

df = apply_labels(df,
                  sonntagsfrage = c("SPD" = 1,
                                 "AFD" = 2,
                                 "CDU/CSU" = 3,
                                 "Gruene" = 4,
                                 "Linke" = 5,
                                 "FDP" = 6,
                                 "Ich waehle nicht" = 7))
df$sonntagsfrage <- as.factor(df$sonntagsfrage)
df


### SCORING


library(psych)
library(tidyverse)

# assign scale items to “keys”
keys<-list(warmth= c("scm_sympatisch", "scm_warmherzig", "scm_gutmuetig"),
           approach= c("bt_approach_konfrontieren", "bt_approach_entgegenstellen", "bt_approach_avoidance"),
           avoidance= c("bt_avoidance_meiden", "-bt_avoidance_zu_tun_haben", "bt_avoidance_abstand_halten"),
           trust= c("ot_ci_vertrauen", "ot_ci_ausnutzen", "ot_ci_tun_was_sie_sagen"),
           cooperativeIntent= c("ot_ci_gut_zurecht_kommen", "ot_ci_zusammenarbeiten")
           )

# Create scores
my.scales <- scoreItems(keys, df, missing=T, impute="none", min=1, max=7)

# information on scales # get stats about the scales (alpha, missings, etc.)
print(my.scales,short=F)

describe(my.scales$scores)
my.scales$scores # scales are NaN in case there have been only missings in a scale

#If we want to delete scales scores for people who did not answer some items for one
#(or more) scales, we can do the following:
my.scales$scores[my.scales$missing > 0] <- NaN #get rid of cases with missing data

# extract the actual scores
my.scores <- as.data.frame(my.scales$scores)
summary(my.scores)

# look into data:
head(my.scores, n=20)

# add scores to df
df <- cbind(df, my.scores)
head(df)

# save as prepared data-set
save(df, file="pretest-prepared.rdata")
