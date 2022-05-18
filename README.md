# sd-workshop2 2022-1
sd workshop2

Christian Gallo

- Completar la lógica de la applicación de pagos de tal manera que al hacer un pago através del microservicio de pagos, el monto de las facturas sea correctamente debitado, es decir, actualmente si una factura debe 1000 y yo hago un pago por 400 a esa factura, el microservicio invoice me sobreescribe el 1000 por 400 en vez de mostrarme el saldo restante 1000-400=600.
- Completar la lógica de la aplicación de tal manera que haya 3 estados para las facturas. 0=debe 1=pagadoparcialmente 2=pagado
- Hacer que las applicaciones se puedan registrar con consul
- Debe ser un pull request a este repositorio sd-workshop2

Bonus:
- Subir las imagenes de la app a Docker hub
- Crear un script en bash que lance toda la aplicación.