#' @name ecv
#' @docType data
#' @usage data(ecv)
#' @title Living Conditions Survey data
#' @description Microdata file containing data from the Living Conditions Survey 
#' (Encuesta de Condiciones de Vida, ECV), as provided by Eustat - the Basque Statistical Office (Spain)
#' 
#' The reference period is the 4th quarter of 2009, 
#' and the reference population is people living in households at the Basque Autonomous Community,
#' @format data frame with 4749 rows (observations) and 26 columns (variables). 
#' 
#' @details The original microdata contains 5242 observations, which are reduced to 4749 after
#' filtering people aged 16 and over. A set of 26 variables was selected for inclusion in this package: common variables
#' with pra data, a weight variable and 13 items measuring some aspect of living conditions.
#'
#' Common variables
#' 
#' \code{territory} Territory: Araba, Gipuzkoa, Bizkaia.
#' 
#' \code{age} Age (6 categories)
#' 
#' \code{sex} Sex
#' 
#' \code{agesex} Combination of age and sex (12 categories)
#' 
#' \code{famsize} Family size: 1, 2, 3 or more
#' 
#' \code{student} Student: yes or no? (logical vector)
#'
#' \code{seekjob} Seeking for a job: yes or no? (logical vector)
#' 
#' \code{employed} Employed: yes or no? (logical vector)
#' 
#' \code{unemployed} Unemployed: yes or no? (logical vector)
#' 
#' \code{inactive} Inactive: yes or no? (logical vector)
#'
#' \code{workhours} Working hours (numerical). Only for occupied.
#'
#' \code{housework} Dedication to housework.
#'  
#' @source \href{http://en.eustat.es/estadisticas/tema_172/opt_0/ti_Condiciones_de_vida/temas.html#axzz37iVNbE00}{Eustat}
#' @keywords datasets
#' @author "Ines Garmendia <ines.garmendia@@gmail.com>"
NULL


#' @name pra
#' @docType data
#' @usage data(pra)
#' @title Population with Relation to Activity Survey data
#' @description Microdata file containing data from the Population in Relation to Activity survey panel 
#' (Encuesta de Población en Relación con la Actividad, PRA),  
#' as provided by Eustat - the Basque Statistical Office (Spain).
#' 
#' The reference period is the 4th quarter of 2009, 
#' and the reference population is people living in households at the Basque Autonomous Community.
#' @format data frame with 10865 rows (observations) and 14 columns (variables). 
#' @details The original microdata contains 12658 observations, which are reduced to 10865 after
#' filtering people aged 16 and over. 
#' A set of 14 variables was selected for inclusion in this package: common variables with ecv data, one weight variable, 
#' and a specific variable correspoding to the labour market segmentation.
#' 
#' Common variables
#' 
#' \code{territory} Territory: Araba, Gipuzkoa, Bizkaia.
#' 
#' \code{age} Age (6 categories)
#' 
#' \code{sex} Sex
#' 
#' \code{agesex} Combination of age and sex (12 categories)
#' 
#' \code{famsize} Family size: 1, 2, 3 or more
#' 
#' \code{student} Student: yes or no? (logical vector)
#'
#' \code{seekjob} Seeking for a job: yes or no? (logical vector)
#' 
#' \code{employed} Employed: yes or no? (logical vector)
#' 
#' \code{unemployed} Unemployed: yes or no? (logical vector)
#' 
#' \code{inactive} Inactive: yes or no? (logical vector)
#'
#' \code{workhours} Working hours (numerical). Only for occupied.
#'
#' \code{housework} Dedication to housework.
#' 
#' @source \href{http://en.eustat.es/ci_ci/estadisticas/tema_37/opt_0/tipo_1/ti_Population_with_relation_to_activity_PRA/temas.html#axzz37idlbZx5}{Eustat}
#' @keywords datasets
#' @author "Ines Garmendia <ines.garmendia@@gmail.com>"
NULL
