# global constants available to the app
# last update:2016-01-17

# constants required for every app
appName <- 'goal'
appTitle <- 'Tägliches Ziel'
app_id <- 'eu.ownyourdata.goal'
helpUrl <- 'https://www.ownyourdata.eu/apps/taegliches-ziel/'

# definition of data structure
currRepoSelect <- ''
appRepos <- list(Vorlage = 'eu.ownyourdata.goal',
                 Verlauf = 'eu.ownyourdata.goal.log')
appStruct <- list(
        Vorlage = list(
                fields      = c('date', 'value'),
                fieldKey    = 'date',
                fieldTypes  = c('date', 'string'),
                fieldInits  = c('empty', 'empty'),
                fieldTitles = c('Datum', 'Ziel'),
                fieldWidths = c(150, 450)),
        Verlauf = list(
                fields      = c('date', 'description'),
                fieldKey    = 'date',
                fieldTypes  = c('date', 'string'),
                fieldInits  = c('empty', 'empty'),
                fieldTitles = c('Datum', 'Text'),
                fieldWidths = c(150, 450)))

# Version information
currVersion <- "0.3.0"
verHistory <- data.frame(rbind(
        c(version = "0.3.0",
          text    = "erstes Release")
))

# app specific constants
goalEmailText <- 'antworte auf dieses Mail und schreibe in die erste Zeile dein heutiges Ziel.</p>Deine letzten 3 Antworten auf die Fragen waren:<br>["RScript":"last3goals"]'
scriptRepo <- 'eu.ownyourdata.goal.script'

# base64 encoded last3goals_skript.R
last3goalsSkript <- 'ZGVmYXVsdEhlYWRlcnM8LWZ1bmN0aW9uKHRva2VuKXsNCmMoJ0FjY2VwdCc9JyovKicsJ0NvbnRlbnQtVHlwZSc9J2FwcGxpY2F0aW9uL2pzb24nLCdBdXRob3JpemF0aW9uJz1wYXN0ZSgnQmVhcmVyJyx0b2tlbikpfQ0KaXRlbXNVcmw8LWZ1bmN0aW9uKHVybCxyZXBvX25hbWUpew0KcGFzdGUwKHVybCwnL2FwaS9yZXBvcy8nLHJlcG9fbmFtZSwnL2l0ZW1zJyl9DQpnZXRUb2tlbjwtZnVuY3Rpb24ocGlhX3VybCxhcHBfa2V5LGFwcF9zZWNyZXQpew0KYXV0aF91cmw8LXBhc3RlMChwaWFfdXJsLCcvb2F1dGgvdG9rZW4nKQ0Kb3B0VGltZW91dDwtUkN1cmw6OmN1cmxPcHRpb25zKGNvbm5lY3R0aW1lb3V0PTEwKQ0KcmVzcG9uc2U8LXRyeUNhdGNoKA0KUkN1cmw6OnBvc3RGb3JtKGF1dGhfdXJsLGNsaWVudF9pZD1hcHBfa2V5LGNsaWVudF9zZWNyZXQ9YXBwX3NlY3JldCxncmFudF90eXBlPSdjbGllbnRfY3JlZGVudGlhbHMnLC5vcHRzPW9wdFRpbWVvdXQpLA0KZXJyb3I9ZnVuY3Rpb24oZSl7cmV0dXJuKE5BKX0pDQppZihpcy5uYShyZXNwb25zZSkpew0KcmV0dXJuKE5BKQ0KfWVsc2V7DQppZihqc29ubGl0ZTo6dmFsaWRhdGUocmVzcG9uc2VbMV0pKXsNCnJldHVybihyanNvbjo6ZnJvbUpTT04ocmVzcG9uc2VbMV0pJGFjY2Vzc190b2tlbikNCn1lbHNlew0KcmV0dXJuKE5BKX19fQ0Kc2V0dXBBcHA8LWZ1bmN0aW9uKHBpYV91cmwsYXBwX2tleSxhcHBfc2VjcmV0KXsNCmFwcF90b2tlbjwtZ2V0VG9rZW4ocGlhX3VybCxhcHBfa2V5LGFwcF9zZWNyZXQpDQppZihpcy5uYShhcHBfdG9rZW4pKXsNCnZlY3RvcigpDQp9ZWxzZXsNCmMoJ3VybCc9cGlhX3VybCwnYXBwX2tleSc9YXBwX2tleSwnYXBwX3NlY3JldCc9YXBwX3NlY3JldCwndG9rZW4nPWFwcF90b2tlbil9fQ0KcjJkPC1mdW5jdGlvbihyZXNwb25zZSl7DQppZihpcy5uYShyZXNwb25zZSkpew0KZGF0YS5mcmFtZSgpDQp9ZWxzZXsNCmlmKG5jaGFyKHJlc3BvbnNlKT4wKXsNCnJldFZhbDwtcmpzb246OmZyb21KU09OKHJlc3BvbnNlKQ0KaWYobGVuZ3RoKHJldFZhbCk9PTApew0KZGF0YS5mcmFtZSgpDQp9ZWxzZXsNCmlmKCdlcnJvciclaW4lbmFtZXMocmV0VmFsKSl7DQpkYXRhLmZyYW1lKCkNCn1lbHNlew0KaWYoIWlzLm51bGwocmV0VmFsJG1lc3NhZ2UpKXsNCmlmKHJldFZhbCRtZXNzYWdlPT0nZXJyb3IuYWNjZXNzRGVuaWVkJyl7DQogZGF0YS5mcmFtZSgpDQp9ZWxzZXsNCiBkby5jYWxsKHJiaW5kLGxhcHBseShyZXRWYWwsZGF0YS5mcmFtZSkpfQ0KfWVsc2V7DQpkby5jYWxsKHJiaW5kLGxhcHBseShyZXRWYWwsZGF0YS5mcmFtZSkpfX19DQp9ZWxzZXsNCmRhdGEuZnJhbWUoKX19fQ0KcmVhZEl0ZW1zPC1mdW5jdGlvbihhcHAscmVwb191cmwpew0KaWYobGVuZ3RoKGFwcCk9PTApew0KZGF0YS5mcmFtZSgpDQpyZXR1cm4oKX0NCmhlYWRlcnM8LWRlZmF1bHRIZWFkZXJzKGFwcFtbJ3Rva2VuJ11dKQ0KdXJsX2RhdGE8LXBhc3RlMChyZXBvX3VybCwnP3NpemU9MjAwMCcpDQpoZWFkZXI8LVJDdXJsOjpiYXNpY0hlYWRlckdhdGhlcmVyKCkNCmRvYzwtdHJ5Q2F0Y2goDQpSQ3VybDo6Z2V0VVJJKHVybF9kYXRhLC5vcHRzPWxpc3QoaHR0cGhlYWRlcj1oZWFkZXJzKSxoZWFkZXJmdW5jdGlvbj1oZWFkZXIkdXBkYXRlKSwNCmVycm9yPWZ1bmN0aW9uKGUpe3JldHVybihOQSl9KQ0KcmVzcG9uc2U8LU5BDQpyZXNwRGF0YTwtZGF0YS5mcmFtZSgpDQppZighaXMubmEoZG9jKSl7DQpyZWNzPC10cnlDYXRjaCgNCmFzLmludGVnZXIoaGVhZGVyJHZhbHVlKClbWydYLVRvdGFsLUNvdW50J11dKSwNCmVycm9yPWZ1bmN0aW9uKGUpe3JldHVybigwKX0pDQppZihyZWNzPjIwMDApew0KZm9yKHBhZ2UgaW4gMDpmbG9vcihyZWNzLzIwMDApKXsNCnVybF9kYXRhPC1wYXN0ZTAocmVwb191cmwsJz9wYWdlPScscGFnZSwnJnNpemU9MjAwMCcpDQpyZXNwb25zZTwtdHJ5Q2F0Y2goDQpSQ3VybDo6Z2V0VVJMKHVybF9kYXRhLC5vcHRzPWxpc3QoaHR0cGhlYWRlcj1oZWFkZXJzKSksDQplcnJvcj1mdW5jdGlvbihlKXtyZXR1cm4oTkEpfSkNCnN1YkRhdGE8LXIyZChyZXNwb25zZSkNCmlmKG5yb3cocmVzcERhdGEpPjApew0KcmVzcERhdGE8LXJiaW5kKHJlc3BEYXRhLHN1YkRhdGEpDQp9ZWxzZXsNCnJlc3BEYXRhPC1zdWJEYXRhfX0NCn1lbHNlew0KcmVzcG9uc2U8LXRyeUNhdGNoKA0KUkN1cmw6OmdldFVSTCh1cmxfZGF0YSwub3B0cz1saXN0KGh0dHBoZWFkZXI9aGVhZGVycykpLA0KZXJyb3I9ZnVuY3Rpb24oZSl7cmV0dXJuKE5BKX0pDQpyZXNwRGF0YTwtcjJkKHJlc3BvbnNlKX19DQpyZXNwRGF0YX0NCnBpYV91cmw8LSdbcGlhX3VybF0nDQphcHBfa2V5PC0nW2FwcF9rZXldJw0KYXBwX3NlY3JldDwtJ1thcHBfc2VjcmV0XScNCmFwcDwtc2V0dXBBcHAocGlhX3VybCxhcHBfa2V5LGFwcF9zZWNyZXQpDQp1cmw8LWl0ZW1zVXJsKHBpYV91cmwsYXBwX2tleSkNCml0ZW1zPC1yZWFkSXRlbXMoYXBwLHVybCkNCnJhdzwtcGFzdGUoYXBwbHkoaGVhZChpdGVtc1tvcmRlcihhcy5EYXRlKGl0ZW1zJGRhdGUsZm9ybWF0PSIlWS0lbS0lZCIpLGRlY3JlYXNpbmc9VFJVRSksYygnZGF0ZScsJ3ZhbHVlJyldLDMpLDEsZnVuY3Rpb24oeCkgcGFzdGUoeCxjb2xsYXBzZT0nOiAnKSksY29sbGFwc2U9Jzxicj4nKQ0KcmVzdWx0IDwtIHV0ZjhUb0ludChwYXN0ZShyYXcsIGNvbGxhcHNlID0gJzxicj4nKSk='