#' @exportMethod remove
setMethod("remove", 
          signature=list(x="filetomatch"), 
          function(x, vars,...){
                  .remove(x = x, vars = vars)
          }
)

#' @exportMethod include
setMethod("include", 
          signature=list(x="filetomatch"), 
          function(x, vars, as){
                  .include(x = x, vars = vars, as = as)
          }
)

#' @exportMethod update
setMethod("update", 
          signature=list(x="filetomatch"), 
          function(x,...){
                  .update(x = x,...)
          }
)

#Select strata values in a 'filematch' object
#' @exportMethod select_strata
setMethod("select_strata", 
          signature=list(x="filetomatch"), 
          function(x, value,...){
                  .select_strata_value(x = x, value = value,...)
          }
)

#' @exportMethod select_observations
setMethod("select_observations", 
          signature=list(x="filetomatch"), 
          function(x, obs,...){
                  .select_observations(x = x, obs = obs,...)
          }
)

#' @exportMethod compare_var
setMethod("compare_var", 
          signature=list(x="filetomatch", y="filetomatch"), 
          function(x, y, var_A, var_B, type = "table", weights = FALSE,...){
                  #de momento comparamos la primera
                  #y solamente tabulate
                  if(identical(weights, TRUE)){
                          weights_A = slot(x, "weights")[1]
                          weights_B = slot(y, "weights")[1]
                  } else {
                          weights_A = NULL
                          weights_B = NULL
                  } 
                  if(identical(type, "table")){
                          t <- tabulate2cat(data_A = slot(x, "data"),
                                       data_B = slot(y, "data"),
                                       var_A = var_A,
                                       var_B = var_B,
                                       weights_A = weights_A,
                                       weights_B = weights_B,...)
                          print(t)
#                           return(t)
                  }
                  if(identical(type, "plot")){
                          g <- plot2cat(data_A = slot(x, "data"),
                                   data_B = slot(y, "data"),
                                   var_A = var_A,
                                   var_B = var_B,
                                   weights_A = weights_A,
                                   weights_B = weights_B,...)
                          print(g)
                  }
                  if(identical(type, "measures")){
                          m <- similarity2cat(data_A = slot(x, "data"),
                                   data_B = slot(y, "data"),
                                   var_A = var_A,
                                   var_B = var_B,
                                   weights_A = weights_A,
                                   weights_B = weights_B,...)
                          return(m)
                  }
          }
)

#' @exportMethod compare_var_strata
setMethod("compare_var_strata", 
          signature=list(x="filetomatch", y="filetomatch"), 
          function(x, y, var_A, var_B, type = "table", weights = FALSE, stratavar, ...){
                  stopifnot(stratavar %in% names(slot(x, "data")))
                  stopifnot(stratavar %in% names(slot(y, "data")))
                  slevels <- levels(slot(x, "data")[, stratavar])
                  #iterate over values creating temporary 'filetomatch' objects
                  sapply(X = slevels, FUN = function(s){
                          xnew <- initialize(x, data = slot(x,"data")[which(slot(x,"data")[, stratavar] == s),])
                          ynew <- initialize(y, data = slot(y,"data")[which(slot(y,"data")[, stratavar] == s),])
                          c <- compare_var(x = xnew, y = ynew, var_A = var_A, var_B = var_B, type = type, weights = weights)
                          if(identical(type, "table") | identical(type, "measures")){
                                  print(paste("Stratum: ", s))
                                  print(c)                                  
                          } else if (identical(type, "plot")){
                                  print(paste("Stratum: ", s))
                                  print(c)
                          }
                  })
          }                  
)

#' @exportMethod compare_matchvars
setMethod("compare_matchvars", 
          signature=list(x="filetomatch", y="filetomatch"), 
          function(x, y, type = "table", weights = FALSE, strata = FALSE, ...){
                  vars <- slot(x, "matchvars")
                  if(strata == TRUE){
                          sapply(vars, FUN = function(var){
                                  compare_var_strata(x = x, y = y, var_A = var, var_B = var, type = type, weights = weights, stratavar = slot(x, "stratavars"),...)
                          })
                  } else {
                          sapply(vars, FUN = function(var){
                                  compare_var(x = x, y = y, var_A = var, var_B = var, type = type, weights = weights,...)
                          })
                  }
})
    
#' @exportMethod predictvalue
setMethod("predictvalue", 
          signature=list(x="filetomatch"), 
          function(x, weights = FALSE,...){
                  data <- slot(x, "data")
                  vars_x <- slot(x, "matchvars")
                  vars_y <- slot(x, "specvars")
                  if(weights){ 
                          weights = slot(x, "weights") 
                  } else {
                          weights = NULL
                  }
                  lapply(vars_y, FUN = function(var){
                          predictvalue_var(data = data, vars_x = vars_x,
                                           var_y = var, weights = weights)
                  })
})

#' @exportMethod concatenate
setMethod("concatenate", 
          signature=list(x="filetomatch", y="filetomatch"), 
          function(x,y){
                  .convertToFusedfile(x=x, y=y, data=.concat(x,y), method="concatenation", role="incomplete", transformation="fillboth")
          }
)

#' @exportMethod match.hotdeck
setMethod("match.hotdeck", 
          signature=list(x='filetomatch', y='filetomatch'), 
          function(x, y, strata = FALSE,...){
                  if(strata == TRUE){
                          #checks
                          stopifnot(!is.null(slot(x, "stratavars")))
                          stopifnot(!is.null(slot(y, "stratavars")))
                          stopifnot(identical(slot(x, "stratavars"), slot(y, "stratavars")))
                          #hot deck with donation classes
                          data <- .match_disthotdeck(x, y, don.class = slot(x, "stratavars"),...)
                  } 
                  if(strata == FALSE){
                          data <- .match_disthotdeck(x, y,...)
                  }
                  #convert to fused file
                  .convertToFusedfile(x = x, y = y, data = data, method = "distance-hotdeck", role = "complete", transformation = "fillreceptor")
          }
)

#' @exportMethod frechet.uncertainty
setMethod("frechet.uncertainty", 
          signature=list(x='filetomatch', y='filetomatch'), 
          function(x, y, var_x, var_y, base, print.f,...){
                  #compute formulas
                  stopifnot(identical(slot(x, "matchvars"), slot(y, "matchvars")))
                  mvars <- slot(x, "matchvars")
                  formulazz <- as.formula(paste("~", paste(mvars, collapse= "+")))
                  formulaxz <- as.formula(paste("~", paste(var_x,"+",paste(mvars, collapse= "+"))))
                  formulayz <- as.formula(paste("~", paste(var_y,"+",paste(mvars, collapse= "+"))))
                  #compute tables based on formulas
                  tab.zz <- xtabs(formulazz, data = slot(base, "data"))
                  tab.xz <- xtabs(formulaxz, data = slot(x, "data"))
                  tab.yz <- xtabs(formulayz, data = slot(y, "data"))
                  # Compute Frechet bounds
                  StatMatch::Frechet.bounds.cat(tab.zz, tab.xz, tab.yz, print.f = print.f,...)
          }
)

# Generic: as.data.frame
#   applies to all 'genericmatch'
#' Coerce 'genericmatch' to 'data.frame'

# setMethod("as.data.frame",
#           signature="filetomatch",
#           function(x, row.names = NULL, optional = FALSE, ...){as(x,"data.frame")})
# 
# setAs("filetomatch","data.frame",function(from){
#         return(from@data)}
# )

