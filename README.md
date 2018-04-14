Stanford Open Policing EDA
================

The
[README](https://github.com/5harad/openpolicing/blob/master/DATA-README.md)
describes the data in more detail. The datasets provided are cleaned
versions in a fairly tidy format; each row denotes one stop, each column
denotes a variable, and each cell denotes a value. Columns denoted with
\*\_raw are original data values, which are standardized to the
corresponding \* columns. Since there are differences across datasets
from state to state, the WI dataset is explored more in depth.

## A first glimpse

The dataset contains 1,059,033 rows and 27 columns.

``` r
d %>% glimpse
```

    ## Observations: 1,059,033
    ## Variables: 27
    ## $ id                    <chr> "WI-2010-0001", "WI-2010-0002", "WI-2010...
    ## $ state                 <chr> "WI", "WI", "WI", "WI", "WI", "WI", "WI"...
    ## $ stop_date             <date> 2010-01-01, 2010-01-03, 2010-01-04, 201...
    ## $ stop_time             <time> 12:50:00, 16:44:00, 09:18:00, 09:04:00,...
    ## $ location_raw          <chr> "DOUGLAS", "DOUGLAS", "FOND DU LAC", "OU...
    ## $ county_name           <chr> "Douglas County", "Douglas County", "Fon...
    ## $ county_fips           <chr> "55031", "55031", "55039", "55087", "550...
    ## $ fine_grained_location <chr> "NA NA 32ND ST N", "W 002 NA", "N 041 NA...
    ## $ police_department     <chr> "WISCONSIN STATE PATROL", "WISCONSIN STA...
    ## $ driver_gender         <chr> "F", "M", "F", "M", "M", "M", "F", "M", ...
    ## $ driver_age_raw        <chr> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, ...
    ## $ driver_age            <chr> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, ...
    ## $ driver_race_raw       <chr> "W", "W", "W", "W", "B", "W", "W", "B", ...
    ## $ driver_race           <chr> "White", "White", "White", "White", "Bla...
    ## $ violation_raw         <chr> "DEFECTIVE HEADLAMP - RIGHT", "SPEEDING ...
    ## $ violation             <chr> "Lights", "Speeding", "Speeding", "Light...
    ## $ search_conducted      <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALSE...
    ## $ search_type_raw       <chr> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, ...
    ## $ search_type           <chr> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, ...
    ## $ contraband_found      <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALSE...
    ## $ stop_outcome          <chr> "Written Warning", "Citation", "Citation...
    ## $ is_arrested           <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALSE...
    ## $ lat                   <dbl> NA, NA, 43.66450, NA, NA, NA, NA, NA, 43...
    ## $ lon                   <dbl> NA, NA, 88.26695, NA, NA, NA, NA, NA, 88...
    ## $ officer_id            <chr> "2241", "2077", "2433", "2228", "2239", ...
    ## $ vehicle_type          <chr> "HONDA CR-V 2002", "MERCURY COUGA NA", "...
    ## $ drugs_related_stop    <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALSE...

``` r
d %>% summary()
```

    ##       id               state             stop_date         
    ##  Length:1059033     Length:1059033     Min.   :2010-01-01  
    ##  Class :character   Class :character   1st Qu.:2012-04-21  
    ##  Mode  :character   Mode  :character   Median :2013-07-05  
    ##                                        Mean   :2013-08-11  
    ##                                        3rd Qu.:2014-12-12  
    ##                                        Max.   :2016-05-16  
    ##                                        NA's   :86          
    ##   stop_time        location_raw       county_name       
    ##  Length:1059033    Length:1059033     Length:1059033    
    ##  Class1:hms        Class :character   Class :character  
    ##  Class2:difftime   Mode  :character   Mode  :character  
    ##  Mode  :numeric                                         
    ##                                                         
    ##                                                         
    ##                                                         
    ##  county_fips        fine_grained_location police_department 
    ##  Length:1059033     Length:1059033        Length:1059033    
    ##  Class :character   Class :character      Class :character  
    ##  Mode  :character   Mode  :character      Mode  :character  
    ##                                                             
    ##                                                             
    ##                                                             
    ##                                                             
    ##  driver_gender      driver_age_raw      driver_age       
    ##  Length:1059033     Length:1059033     Length:1059033    
    ##  Class :character   Class :character   Class :character  
    ##  Mode  :character   Mode  :character   Mode  :character  
    ##                                                          
    ##                                                          
    ##                                                          
    ##                                                          
    ##  driver_race_raw    driver_race        violation_raw     
    ##  Length:1059033     Length:1059033     Length:1059033    
    ##  Class :character   Class :character   Class :character  
    ##  Mode  :character   Mode  :character   Mode  :character  
    ##                                                          
    ##                                                          
    ##                                                          
    ##                                                          
    ##   violation         search_conducted search_type_raw    search_type       
    ##  Length:1059033     Mode :logical    Length:1059033     Length:1059033    
    ##  Class :character   FALSE:892928     Class :character   Class :character  
    ##  Mode  :character   TRUE :14334      Mode  :character   Mode  :character  
    ##                     NA's :151771                                          
    ##                                                                           
    ##                                                                           
    ##                                                                           
    ##  contraband_found stop_outcome       is_arrested          lat          
    ##  Mode :logical    Length:1059033     Mode :logical   Min.   :     5.0  
    ##  FALSE:1051752    Class :character   FALSE:1043114   1st Qu.:    43.1  
    ##  TRUE :7281       Mode  :character   TRUE :15919     Median :    43.9  
    ##                                                      Mean   :    53.0  
    ##                                                      3rd Qu.:    44.7  
    ##                                                      Max.   :463525.0  
    ##                                                      NA's   :712386    
    ##       lon            officer_id        vehicle_type      
    ##  Min.   :   -92.8   Length:1059033     Length:1059033    
    ##  1st Qu.:   -90.2   Class :character   Class :character  
    ##  Median :   -89.0   Mode  :character   Mode  :character  
    ##  Mean   :   -25.9                                        
    ##  3rd Qu.:    87.9                                        
    ##  Max.   :905303.0                                        
    ##  NA's   :712392                                          
    ##  drugs_related_stop
    ##  Mode :logical     
    ##  FALSE:1053671     
    ##  TRUE :5362        
    ##                    
    ##                    
    ##                    
    ## 

## id is the primary key

The variable id is the primary key which uniquely identifies each stop.

``` r
d %>% 
  count(id) %>% 
  filter(n > 1)
```

    ## # A tibble: 0 x 2
    ## # ... with 2 variables: id <chr>, n <int>

## state all WI

Each observation’s state is WI. The
[documentation](https://github.com/5harad/openpolicing/blob/master/DATA-README.md)
states this variable is “the two-letter code for the state in which the
stop occurred.” Note that this conflicts with some results found by
looking at latitude/longitude, where some stops were outside WI borders
in neighboring states.

``` r
# each stop was in WI
d %>% 
  group_by(state) %>%
  count()
```

    ## # A tibble: 1 x 2
    ## # Groups:   state [1]
    ##   state       n
    ##   <chr>   <int>
    ## 1 WI    1059033

``` r
nrow(d)
```

    ## [1] 1059033

## Stop dates

The following explores the number of stops made by day, year, and month.

``` r
# days in dataset with most stops
d %>%
  group_by(stop_date) %>% 
  count() %>% 
  arrange(desc(n))
```

    ## # A tibble: 2,073 x 2
    ## # Groups:   stop_date [2,073]
    ##    stop_date      n
    ##    <date>     <int>
    ##  1 2013-05-24  1445
    ##  2 2011-05-27  1349
    ##  3 2012-08-31  1308
    ##  4 2011-05-28  1247
    ##  5 2012-05-25  1228
    ##  6 2011-05-29  1218
    ##  7 2013-05-25  1205
    ##  8 2012-09-01  1203
    ##  9 2013-05-26  1186
    ## 10 2011-05-30  1183
    ## # ... with 2,063 more rows

The amount of stops for 2011 - 2015 is comparable. There are less stops
in the dataset for 2010, and the data for 2016 stops at 5/16/2016.

``` r
# most stops by year
d %>%
  select(stop_date) %>% 
  transmute(yr = year(stop_date)) %>% 
  group_by(yr) %>% 
  count() %>% 
  arrange(desc(n))
```

    ## # A tibble: 8 x 2
    ## # Groups:   yr [8]
    ##      yr      n
    ##   <dbl>  <int>
    ## 1  2012 219988
    ## 2  2013 195790
    ## 3  2011 195719
    ## 4  2014 184481
    ## 5  2015 183832
    ## 6  2016  73161
    ## 7  2010   5976
    ## 8    NA     86

Months with largest amount of stops. Note this includes 2010 and 2016.

``` r
# most stops by month
d %>%
  select(stop_date) %>% 
  transmute(month = month(stop_date)) %>% 
  group_by(month) %>% 
  count() %>% 
  arrange(desc(n))
```

    ## # A tibble: 13 x 2
    ## # Groups:   month [13]
    ##    month      n
    ##    <dbl>  <int>
    ##  1  5.00 109510
    ##  2  4.00  97360
    ##  3  3.00  96530
    ##  4  1.00  92452
    ##  5  7.00  92213
    ##  6  9.00  89608
    ##  7  8.00  85671
    ##  8  2.00  85619
    ##  9 10.0   84223
    ## 10  6.00  82979
    ## 11 11.0   74304
    ## 12 12.0   68478
    ## 13 NA        86

Days of the week with largest amount of stops. Note this includes 2010
and 2016.

``` r
# most stops by day of the week
d %>%
  select(stop_date) %>% 
  transmute(day = wday(stop_date, label = TRUE)) %>% 
  group_by(day) %>% 
  count() %>% 
  arrange(desc(n))
```

    ## # A tibble: 8 x 2
    ## # Groups:   day [8]
    ##   day        n
    ##   <ord>  <int>
    ## 1 Sat   178788
    ## 2 Sun   169625
    ## 3 Fri   168439
    ## 4 Thu   139460
    ## 5 Wed   135002
    ## 6 Tue   134982
    ## 7 Mon   132651
    ## 8 <NA>      86

Days of the month with largest amount of stops. Note this includes 2010
and 2016.

``` r
# most stops by day of the month
d %>%
  select(stop_date) %>% 
  transmute(day = mday(stop_date)) %>% 
  group_by(day) %>% 
  count() %>% 
  arrange(desc(n))
```

    ## # A tibble: 32 x 2
    ## # Groups:   day [32]
    ##      day     n
    ##    <int> <int>
    ##  1     7 36316
    ##  2     6 36274
    ##  3     4 36273
    ##  4     2 35988
    ##  5     1 35983
    ##  6    25 35895
    ##  7    27 35757
    ##  8     5 35694
    ##  9     8 35491
    ## 10    24 35313
    ## # ... with 22 more rows

## Stop times

Which hours are the most number of stops made?

``` r
d %>% 
  group_by(hour(stop_time)) %>% 
  count() %>% 
  arrange(desc(n))
```

    ## # A tibble: 25 x 2
    ## # Groups:   hour(stop_time) [25]
    ##    `hour(stop_time)`      n
    ##                <int>  <int>
    ##  1                NA 286411
    ##  2                16  58567
    ##  3                10  52783
    ##  4                17  52314
    ##  5                13  52250
    ##  6                12  50407
    ##  7                 9  49345
    ##  8                15  47570
    ##  9                11  46648
    ## 10                18  43313
    ## # ... with 15 more rows

## Geographic: location\_raw, county\_name, county\_fips, fine\_grained\_location

The counties with the highest frequency of stops. The column
county\_name is the name of the county, while county\_fips is the
corresponding FIPS code.

``` r
d %>%
  group_by(county_name) %>% 
  count() %>% 
  arrange(desc(n))
```

    ## # A tibble: 72 x 2
    ## # Groups:   county_name [72]
    ##    county_name           n
    ##    <chr>             <int>
    ##  1 Dane County       69269
    ##  2 Monroe County     48139
    ##  3 Eau Claire County 38883
    ##  4 St. Croix County  38144
    ##  5 Jefferson County  36006
    ##  6 Dunn County       35866
    ##  7 Kenosha County    32760
    ##  8 Jackson County    32547
    ##  9 Rock County       31596
    ## 10 Columbia County   30204
    ## # ... with 62 more rows

``` r
d %>%
  group_by(county_fips) %>% 
  count() %>% 
  arrange(desc(n))
```

    ## # A tibble: 72 x 2
    ## # Groups:   county_fips [72]
    ##    county_fips     n
    ##    <chr>       <int>
    ##  1 55025       69269
    ##  2 55081       48139
    ##  3 55035       38883
    ##  4 55109       38144
    ##  5 55055       36006
    ##  6 55033       35866
    ##  7 55059       32760
    ##  8 55053       32547
    ##  9 55105       31596
    ## 10 55021       30204
    ## # ... with 62 more rows

Note county\_name = location\_raw + " County“. These columns are
repetitive, so one of these can be dropped. location\_raw is the
original values from which the standardized county name and FIPS code is
obtained.

``` r
# location_raw is part of county_name before " County"
d %>%
  select(county_name) %>% 
  separate(county_name, into = c("county", "word_county"), sep = -8) %>%
  select(county) %>% 
  mutate(county = toupper(county)) %>% 
  identical(d %>% select(location_raw) %>% transmute(county = location_raw))
```

    ## [1] TRUE

``` r
# the last word of county_name is always "County"
d %>%
  select(county_name) %>% 
  separate(county_name, into = c("county", "word_county"), sep = -8) %>% 
  group_by(word_county) %>% 
  count()
```

    ## # A tibble: 1 x 2
    ## # Groups:   word_county [1]
    ##   word_county       n
    ##   <chr>         <int>
    ## 1 " County"   1059033

More specific information about the location is provided with
fine\_grained\_location. Below is a simplistic view of where the largest
number of stops occurred. Note there are many NAs and more in-depth
analysis can be done.

``` r
# the last word of county_name is always "County"
d %>%
  group_by(fine_grained_location) %>% 
  count() %>% 
  arrange(desc(n))
```

    ## # A tibble: 92,283 x 2
    ## # Groups:   fine_grained_location [92,283]
    ##    fine_grained_location     n
    ##    <chr>                 <int>
    ##  1 W 094 NA              25117
    ##  2 E 094 NA              24850
    ##  3 N 041 NA              15812
    ##  4 NA NA NA              15742
    ##  5 N 039 NA              14535
    ##  6 S 039 NA              13599
    ##  7 N 043 NA              11662
    ##  8 S 041 NA              11007
    ##  9 W 090 NA               9955
    ## 10 E 090 NA               6470
    ## # ... with 92,273 more rows

## Police department

Departments which made the most number of stops. We speculate that
Wisconsin State Patrol is a general category, while WI State Patrol
<region>/<office> are more specific. The [Wisconsin DOT
website](http://wisconsindot.gov/Pages/about-wisdot/who-we-are/dsp/loc-contact.aspx)
indicates the various regions – Southwest, Southeast, Northeast, North
Central, Northwest, which correspond to the abbreviations SWR, SER, NER,
NCR, and NWR below, respectively. Based on the same page previously and
the [Wikipedia
page](https://en.wikipedia.org/wiki/Wisconsin_State_Patrol#The_State_Patrol_today),
there are “offices in DeForest (Madison), Waukesha, Fond du Lac, Wausau,
Tomah, Eau Claire and Spooner”, which correspond to the abbreviations
DEF, WKE, FON, WSA, TOM, EAU, and SPO.

It is unclear what ZWI State Patrol refers to; this may be some sort of
error in the data.

``` r
d %>% 
  group_by(police_department) %>% 
  count() %>% 
  arrange(desc(n))
```

    ## # A tibble: 9 x 2
    ## # Groups:   police_department [9]
    ##   police_department            n
    ##   <chr>                    <int>
    ## 1 WISCONSIN STATE PATROL  772699
    ## 2 WI STATE PATROL SWR/DEF  82733
    ## 3 WI STATE PATROL NWR/EAU  47223
    ## 4 WI STATE PATROL NER/FON  36585
    ## 5 WI STATE PATROL NCR/WSA  36022
    ## 6 WI STATE PATROL SER/WKE  33894
    ## 7 WI STATE PATROL SWR/TOM  32713
    ## 8 WI STATE PATROL NWR/SPO  17154
    ## 9 ZWI STATE PATROL            10

## Driver gender

Males in WI were stopped more often than females. There are also a
significant number of NAs.

``` r
d %>% 
  group_by(driver_gender) %>% 
  count() %>% 
  arrange(desc(n))
```

    ## # A tibble: 3 x 2
    ## # Groups:   driver_gender [3]
    ##   driver_gender      n
    ##   <chr>          <int>
    ## 1 M             600597
    ## 2 F             305575
    ## 3 <NA>          152861

## Driver age

Driver age information is all NA.

``` r
d %>% 
  group_by(driver_age_raw) %>% 
  count()
```

    ## # A tibble: 1 x 2
    ## # Groups:   driver_age_raw [1]
    ##   driver_age_raw       n
    ##   <chr>            <int>
    ## 1 <NA>           1059033

``` r
d %>% 
  group_by(driver_age) %>% 
  count()
```

    ## # A tibble: 1 x 2
    ## # Groups:   driver_age [1]
    ##   driver_age       n
    ##   <chr>        <int>
    ## 1 <NA>       1059033

## Driver race

``` r
# driver_race_raw -> driver_race
# A -> Asian
# B -> Black
# H -> Hispanic
# I -> Other
# W -> White
# O + NA -> NA
# What is O? 
d %>%
  group_by(driver_race_raw) %>% 
  count() %>% 
  arrange(desc(n))
```

    ## # A tibble: 7 x 2
    ## # Groups:   driver_race_raw [7]
    ##   driver_race_raw      n
    ##   <chr>            <int>
    ## 1 W               778227
    ## 2 <NA>            153597
    ## 3 B                56050
    ## 4 H                35210
    ## 5 A                24577
    ## 6 I                11361
    ## 7 O                   11

``` r
d %>%
  group_by(driver_race) %>% 
  count() %>% 
  arrange(desc(n))
```

    ## # A tibble: 6 x 2
    ## # Groups:   driver_race [6]
    ##   driver_race      n
    ##   <chr>        <int>
    ## 1 White       778227
    ## 2 <NA>        153608
    ## 3 Black        56050
    ## 4 Hispanic     35210
    ## 5 Asian        24577
    ## 6 Other        11361

## Violations

violation\_raw denotes the original data values, while violation is the
standardized category of the violation. Note that some stops contain
multiple violations; to explore this more in-depth, cases with multiple
violations could be split.

``` r
# most common violations (specific)
d %>% 
  group_by(violation_raw) %>% 
  count() %>% 
  arrange(desc(n))
```

    ## # A tibble: 199,222 x 2
    ## # Groups:   violation_raw [199,222]
    ##    violation_raw                            n
    ##    <chr>                                <int>
    ##  1 SPEEDING IN 65 MPH ZONE              72079
    ##  2 SPEEDING ON FREEWAY (11-15 MPH)      57885
    ##  3 SPEEDING IN 55 MPH ZONE              48136
    ##  4 SPEEDING ON FREEWAY (16-19 MPH)      34252
    ##  5 SPEEDING IN 55 MPH ZONE (11-15 MPH)  33265
    ##  6 SPEEDING ON FREEWAY (1-10 MPH)       25491
    ##  7 VEHICLE OPERATOR FAIL/WEAR SEAT BELT 23683
    ##  8 SPEEDING IN 55 MPH ZONE (16-19 MPH)  17214
    ##  9 SPEEDING IN 55 MPH ZONE (1-10 MPH)   16763
    ## 10 SPEEDING ON FREEWAY (20-24 MPH)      15501
    ## # ... with 199,212 more rows

``` r
# most common violations (general)
d %>% 
  group_by(violation) %>% 
  count() %>% 
  arrange(desc(n))
```

    ## # A tibble: 1,439 x 2
    ## # Groups:   violation [1,439]
    ##    violation                          n
    ##    <chr>                          <int>
    ##  1 Speeding                      381596
    ##  2 Paperwork,Speeding             87885
    ##  3 Other (non-mapped)             52337
    ##  4 Lights                         33135
    ##  5 Seat belt                      31286
    ##  6 Registration/plates            28527
    ##  7 Safe movement                  26519
    ##  8 Safe movement,Speeding         21194
    ##  9 Registration/plates,Speeding   18213
    ## 10 Paperwork,Registration/plates  15778
    ## # ... with 1,429 more rows

## Search type

``` r
# most common search types
d %>% 
  group_by(search_type) %>% 
  count() %>%
  arrange(desc(n))
```

    ## # A tibble: 34 x 2
    ## # Groups:   search_type [34]
    ##    search_type                                     n
    ##    <chr>                                       <int>
    ##  1 <NA>                                      1044869
    ##  2 Incident to Arrest                           4861
    ##  3 Probable Cause                               4194
    ##  4 Incident to Arrest,Probable Cause            1931
    ##  5 Warrant                                      1206
    ##  6 Incident to Arrest,Warrant                    853
    ##  7 Probable Cause,Warrant                        290
    ##  8 Consent                                       209
    ##  9 Incident to Arrest,Probable Cause,Warrant     202
    ## 10 Consent,Probable Cause                         73
    ## # ... with 24 more rows

Note that search\_type\_raw and search\_type are the same.

``` r
identical(d$search_type, d$search_type_raw)
```

    ## [1] TRUE

## Stop outcome

For stops with multiple outcomes, the value is the most severe outcome.

``` r
d %>% 
  group_by(stop_outcome) %>% 
  count() %>%
  arrange(desc(n))
```

    ## # A tibble: 6 x 2
    ## # Groups:   stop_outcome [6]
    ##   stop_outcome         n
    ##   <chr>            <int>
    ## 1 Written Warning 525499
    ## 2 Citation        514095
    ## 3 Arrest           15919
    ## 4 Verbal Warning    2460
    ## 5 No Action          942
    ## 6 <NA>               118

## Latitude, longitude

According to the Wikipedia page for Wisconsin, latitude ranges from
42°30’ N to 47°05′ N, while longitude ranges from 86°46′ W to 92°54′ W.
There appear to be some errors in values of latitude and longitude, with
some values not fitting in the range suggested on Wikipedia either in
magnitude and/or direction (some values of longitude are positive and
therefore E, not W).

Filtering the latitude by this range reveals that there appears to be
some errors as shown below, with some latitude values being too small or
large. For instance, the latitude 440721.0000 may have been intended to
be 44.0721. (The row with latitude 440721.0000 and longitude
874232.00000 may be intended to be latitude 44.0721 and longitude
-87.4232, which maps to a position in Lake Michigan near a line Google
Maps labels as Ludington Manitowoc. This seems to be some kind of
bridge/ferry?)

``` r
d %>% 
  filter(lat < 42.3 | lat > 47.05) %>% 
  arrange(lat) %>% 
  select(id, lat, lon, everything())
```

    ## # A tibble: 13 x 27
    ##    id                  lat     lon state stop_date  stop_time location_raw
    ##    <chr>             <dbl>   <dbl> <chr> <date>     <time>    <chr>       
    ##  1 WI-2011-0256…      4.96  9.26e¹ WI    2011-02-17 05:07     ST. CROIX   
    ##  2 WI-2010-2141       9.00 NA      WI    2010-12-11 08:10     WAUKESHA    
    ##  3 WI-2011-0327…     41.3   9.11e¹ WI    2011-03-10 09:40     JACKSON     
    ##  4 WI-2011-1416…     42.0   9.30e¹ WI    2011-09-22 08:43     WAUKESHA    
    ##  5 WI-2012-0968…     42.0  NA      WI    2012-06-14 09:50     GRANT       
    ##  6 WI-2014-0623…     42.0  NA      WI    2014-05-18 11:45     EAU CLAIRE  
    ##  7 WI-2010-4007  440721     8.74e⁵ WI    2010-12-23 07:16     MANITOWOC   
    ##  8 WI-2010-4026  441350     8.75e⁵ WI    2010-12-23 08:47     MANITOWOC   
    ##  9 WI-2010-4070  441725     8.75e⁵ WI    2010-12-23 10:59     MANITOWOC   
    ## 10 WI-2010-4040  442040     8.75e⁵ WI    2010-12-23 09:19     MANITOWOC   
    ## 11 WI-2011-0474… 443008     8.80e⁵ WI    2011-04-06 11:48     BROWN       
    ## 12 WI-2011-0474… 443008     8.80e⁵ WI    2011-04-06 11:48     BROWN       
    ## 13 WI-2010-1575  463525     9.05e⁵ WI    2010-12-07 08:25     ASHLAND     
    ## # ... with 20 more variables: county_name <chr>, county_fips <chr>,
    ## #   fine_grained_location <chr>, police_department <chr>,
    ## #   driver_gender <chr>, driver_age_raw <chr>, driver_age <chr>,
    ## #   driver_race_raw <chr>, driver_race <chr>, violation_raw <chr>,
    ## #   violation <chr>, search_conducted <lgl>, search_type_raw <chr>,
    ## #   search_type <chr>, contraband_found <lgl>, stop_outcome <chr>,
    ## #   is_arrested <lgl>, officer_id <chr>, vehicle_type <chr>,
    ## #   drugs_related_stop <lgl>

There are some longitude values which are positive, corresponding to E
instead of W. These should most likely be negative instead of positive;
otherwise this maps to locations on the other side of the world in areas
like China.

``` r
d %>% 
  filter(lon < -92.54 | lon > -86.46) %>% 
  arrange(lat) %>% 
  select(id, lat, lon, everything())
```

    ## # A tibble: 92,867 x 27
    ##    id        lat   lon state stop_date  stop_time location_raw county_name
    ##    <chr>   <dbl> <dbl> <chr> <date>     <time>    <chr>        <chr>      
    ##  1 WI-201…  4.96  92.6 WI    2011-02-17 05:07     ST. CROIX    St. Croix …
    ##  2 WI-201… 41.3   91.1 WI    2011-03-10 09:40     JACKSON      Jackson Co…
    ##  3 WI-201… 42.0   93.0 WI    2011-09-22 08:43     WAUKESHA     Waukesha C…
    ##  4 WI-201… 42.5   89.0 WI    2011-06-01 10:17     ROCK         Rock County
    ##  5 WI-201… 42.5   88.0 WI    2011-03-16 10:31     KENOSHA      Kenosha Co…
    ##  6 WI-201… 42.5   88.0 WI    2010-12-16 10:01     KENOSHA      Kenosha Co…
    ##  7 WI-201… 42.5   88.0 WI    2010-12-16 11:57     KENOSHA      Kenosha Co…
    ##  8 WI-201… 42.5   88.0 WI    2010-12-16 13:14     KENOSHA      Kenosha Co…
    ##  9 WI-201… 42.5   88.0 WI    2010-12-17 08:53     KENOSHA      Kenosha Co…
    ## 10 WI-201… 42.5   88.0 WI    2010-12-17 09:50     KENOSHA      Kenosha Co…
    ## # ... with 92,857 more rows, and 19 more variables: county_fips <chr>,
    ## #   fine_grained_location <chr>, police_department <chr>,
    ## #   driver_gender <chr>, driver_age_raw <chr>, driver_age <chr>,
    ## #   driver_race_raw <chr>, driver_race <chr>, violation_raw <chr>,
    ## #   violation <chr>, search_conducted <lgl>, search_type_raw <chr>,
    ## #   search_type <chr>, contraband_found <lgl>, stop_outcome <chr>,
    ## #   is_arrested <lgl>, officer_id <chr>, vehicle_type <chr>,
    ## #   drugs_related_stop <lgl>

There are also locations which map to locations outside WI borders into
neighboring states. For instance, there are many stops with the latitude
44.91696 and longitude 92.86195. However, this corresponds to a location
in northern China, near the border with Mongolia. This seems to be an
error, with the intended longitude of -92.86195. The latitude 44.91696
and longitude -92.86195 maps to a location in eastern Minnesota, which
is not too far from the western border to Wisconsin. Further inspection
reveals that officer with id 1787 seems to frequent this area, as the
officer has made 469 stops within the time span of the dataset.

``` r
d %>% 
  filter(lat == 44.91696 | lon == 92.86195) %>% 
  group_by(officer_id) %>% 
  count()
```

    ## # A tibble: 1 x 2
    ## # Groups:   officer_id [1]
    ##   officer_id     n
    ##   <chr>      <int>
    ## 1 1787         469

## Officer

``` r
d %>% 
  group_by(officer_id) %>% 
  count() %>% 
  arrange(desc(n))
```

    ## # A tibble: 549 x 2
    ## # Groups:   officer_id [549]
    ##    officer_id     n
    ##    <chr>      <int>
    ##  1 2286       10786
    ##  2 2072       10022
    ##  3 2077        8254
    ##  4 2195        7801
    ##  5 2187        7479
    ##  6 2347        7144
    ##  7 2147        6742
    ##  8 2339        6576
    ##  9 2180        6389
    ## 10 2120        6369
    ## # ... with 539 more rows

## Vehicle type

This column seems to be in the format (manufacturer, model, year). The
following is a simple first look at what combination of these
characteristics is most frequent. To explore this in more depth, this
could be separated into separate columns for manufacturer, model, and
year.

``` r
d %>% 
  group_by(vehicle_type) %>% 
  count() %>% 
  arrange(desc(n))
```

    ## # A tibble: 87,955 x 2
    ## # Groups:   vehicle_type [87,955]
    ##    vehicle_type                   n
    ##    <chr>                      <int>
    ##  1 NA NA NA                  133538
    ##  2 CHEVROLET NOT REQUIRED NA   3588
    ##  3 CHEVROLET NA NA             3402
    ##  4 FORD NOT REQUIRED NA        2760
    ##  5 FORD NA NA                  2540
    ##  6 DODGE NOT REQUIRED NA       1532
    ##  7 TOYOTA NOT REQUIRED NA      1373
    ##  8 DODGE NA NA                 1305
    ##  9 TOYOTA NA NA                1288
    ## 10 CHEVROLET NA 2004           1242
    ## # ... with 87,945 more rows

## Missing race data by officer

The following is sorted in descending order by number of stops an
officer has made, and missingRaceRatio indicates what proportion of
their total stops is missing race.

``` r
d %>% 
  mutate(missingRace = is.na(driver_race)) %>% 
  group_by(officer_id) %>% 
  summarise(missingRaceRatio = mean(missingRace == TRUE), count = n()) %>% 
  arrange(desc(count))
```

    ## # A tibble: 549 x 3
    ##    officer_id missingRaceRatio count
    ##    <chr>                 <dbl> <int>
    ##  1 2286                0.110   10786
    ##  2 2072                0.216   10022
    ##  3 2077                0.138    8254
    ##  4 2195                0.231    7801
    ##  5 2187                0.0420   7479
    ##  6 2347                0.00406  7144
    ##  7 2147                0.261    6742
    ##  8 2339                0.170    6576
    ##  9 2180                0.261    6389
    ## 10 2120                0.0188   6369
    ## # ... with 539 more rows

## Missing race data by police department

Stops where the police\_department is Wisconsin State Patrol have a
surprisingly small amount of missing race values, while stops where the
police\_department is more specific tend to have higher instances of
race missing.

``` r
d %>% 
  mutate(missingRace = is.na(driver_race)) %>% 
  group_by(police_department) %>% 
  summarise(missingRaceRatio = mean(missingRace == TRUE), count = n()) %>% 
  arrange(desc(count))
```

    ## # A tibble: 9 x 3
    ##   police_department       missingRaceRatio  count
    ##   <chr>                              <dbl>  <int>
    ## 1 WISCONSIN STATE PATROL           0.00219 772699
    ## 2 WI STATE PATROL SWR/DEF          0.423    82733
    ## 3 WI STATE PATROL NWR/EAU          0.518    47223
    ## 4 WI STATE PATROL NER/FON          0.526    36585
    ## 5 WI STATE PATROL NCR/WSA          0.535    36022
    ## 6 WI STATE PATROL SER/WKE          0.440    33894
    ## 7 WI STATE PATROL SWR/TOM          0.824    32713
    ## 8 WI STATE PATROL NWR/SPO          0.700    17154
    ## 9 ZWI STATE PATROL                 0.500       10

## Stops with missing race data tend to miss other information about stop

It seems to be the case that stops with missing information about driver
race often are missing other information about the stop overall,
including driver gender, whether or not a search was conducted, stop
time, and information about the vehicle (manufacturer, model, and year
all missing). Unfortunately, all values for driver age are missing in
the dataset, otherwise that could be explored as well.

``` r
missingRace <- d %>% filter(is.na(driver_race))
sprintf("Number of stops with missing race: %s", missingRace %>% nrow()) 
```

    ## [1] "Number of stops with missing race: 153608"

``` r
sprintf("Number of stops with missing race, gender, search conducted, stop time, vehicle information: %s", d %>% filter(is.na(driver_race), is.na(driver_gender), is.na(search_conducted), is.na(stop_time), vehicle_type == "NA NA NA") %>% nrow())
```

    ## [1] "Number of stops with missing race, gender, search conducted, stop time, vehicle information: 133372"
