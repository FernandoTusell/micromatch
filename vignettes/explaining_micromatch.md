---
title: "Explaining micromatch package"
author: "Ines Garmendia"
date: "2014-07-15"
output:
  html_document:
    theme: null
    highlight: null
    self_contained: no
    includes:
      in_header: assets/header.html
---

<!--
%\VignetteEngine{knitr::rmarkdown}
%\VignetteIndexEntry{Explaining micromatch package}
-->

### NO LEER: Esto es solamente una prueba para crear un vignette

En este documento pretendemos mostrar unos cuantos usos de las funciones ahora mismo programadas en el paquete micromatch. Estas funciones han sido utilizadas para efectuar un ejercicio concreto entre las encuestas ECV y PRA de Eustat; ahora lo que interesa es analizar si estas funciones podrían generalizarse a otros casos.

Los datos de dos encuestas de Eustat, ECV y PRA, se han cargado en el propio paquete micromatch. Está pendiente documentarlas.
### Cargar paquete y datos

**Encuestas de Eustat**
Datos en el mismo micromatch:
1. PRA: Población en relación con la actividad
2. ECV: Encuesta de condiciones de vida

```
## [1] 4749  417
```

```
## [1] 10865    73
```

## References