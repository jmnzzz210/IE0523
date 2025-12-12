# Descripción estructural del controlador de cajero automático

---

En esta tarea se obtuvo la descripción estructural del código realizado en la tarea 1, la cual trata sobre el controlador del cajero automático.
Para esta tarea se utiliza la herramienta yosys, además de que esta descripción estructural se realizará de manera que cumpla con la librería cmos_cells. 
Con estas herramientas se genera la creación de una descripción estructural, de manera que se puede verificar que el diseño es realizable y además de que no contiene latches y permite la creación del controlador con los componentes que se encuentran en la librería cmos_cells.

## Instrucciones para ejecutar las simulaciones
Para facilitar la ejecución de los resultados se realizó un makefile, el cual se encarga se compilar la descripción conductual, la síntesis de la descripción conductual y la generación de las simulaciones, así de presentar un GTKWave el cual contiene las señales importantes colocadas, por lo que es solamente ejecutar con un `make`.

```bash
git clone https://github.com/jmnzzz210/IE0523
cd IE0523
cd Tarea2
cd src
make
```

 La información del diseño arquitectónico, plan de pruebas y los resultados obtenidos en este trabajo se encuentran en el reporte, el cual se encuentra dando click <a href="https://jmnzzz210.github.io/IE0523/Tarea2/docs/reporte.pdf" target="_blank">aquí</a>.
