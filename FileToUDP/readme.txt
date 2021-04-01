To simulate the Sarmiento's UDP datagrams, execute the following sentences:

Navigation UDP:
java -jar FileToUDP.jar http://ortelius.cmima.csic.es/datos/Sarmiento/05-2016/posicion.raw/25052016.posicion.raw 3101 1

Meteo UDP:
java -jar FileToUDP.jar http://ortelius.cmima.csic.es/datos/Sarmiento/05-2016/meteo.raw/08052016.meteo.raw 3102 1

Thermosalinometer UDP:
java -jar FileToUDP.jar http://ortelius.cmima.csic.es/datos/Sarmiento/05-2016/termosal.raw/09052016.termosal.raw 3103 1
