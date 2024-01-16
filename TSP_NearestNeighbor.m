% TSP por vecino más cercano
close all;
clear all;
clc;

% este arreglo contiene los pares coordenados de las ciudades ejemplo
ciudades_ejemplo = [30, 18; 23, 45; 12, 54; 33, 1; 64, 36; 78, 47; 55, 15; 22, 29; 11, 6;24, 32; 0, 0];


num_ciudades = size(ciudades_ejemplo,1);    % obtenemos la cantidad de ciudades
ruta = zeros(1, num_ciudades);              % vector donde se guardará la ruta óptima
ruta(1) = 1;                                % se comienza desde la ciudad 1
visitadas = false(1, num_ciudades);         % vector de booleanos para saber si ya se visitó alguna ciudad
visitadas(1) = true;                        % como se inicia en la ciudad 1 se asigna el valor verdadero

% ciclo para construir el vector que indicará la ruta
for i = 2 : num_ciudades
    ciudad_actual = ruta(i-1);      % el ciclo siempre nos posicionará en la proxima ciudad, por eso la ciudad atual es i-1
    distancia_minima = inf;         % se le asigna un valor muy grande para que cualquier distancia siguiente sea la mínima
    ciudad_mas_cercana = 0;         % en esta variable se guardara el vecino más cercano

    % ciclo para encontrar el vecino más cercano
    for proxima_ciudad = 1 : num_ciudades
       
        % si la ciudad no se ha visitado aún, se verificará si la distancia
        % a dicha ciudad es la más corta
        if ~visitadas(proxima_ciudad)      
            
            % se calcula la distancia a la ciudad
            d = norm(ciudades_ejemplo(ciudad_actual, :) - ciudades_ejemplo(proxima_ciudad, :)); 
           
            % si la distanccia a esta ciudad es la distancia mínima se
            % actualiza la variable distancia_minima y se asigna el número
            % ded ciudad a la variable ciudad_mas_cerana
            if d < distancia_minima
                distancia_minima = d;
                ciudad_mas_cercana = proxima_ciudad;
            end
        end
    end
   
    % al final de este ciclo for se asigna en el vector ruta al vecino más
    % cercano y se da por visitada esa ciudad
    ruta(i) = ciudad_mas_cercana;
    visitadas(ciudad_mas_cercana) = true;
end

% se añade el regreso a la ciudad inicial
ruta = [ruta, ruta(1)];

% la ruta obtenida es igual a la ruta optima
ruta_optima = ruta; 

% se muestra en consola el resultado
disp('Ruta óptima:');
disp(ruta_optima);

% para graficar el resultado
% los vectores tendrán los valores de las coordenadas
% en x e y de las ciudades

x = zeros(1,num_ciudades);
y = zeros(1,num_ciudades);

for i = 1 : num_ciudades
    for j = 1 : num_ciudades
        if ruta_optima(i) == j 
            x(i) = ciudades_ejemplo(j,1); 
            y(i) = ciudades_ejemplo(j,2);
        end
    end
end

x = [x,x(1)];
y = [y,y(1)];

figure
plot(x,y,"-o",'LineWidth', 2);          
title("TSP por vecino más cercano");
xlabel("Eje X");
ylabel("Eje Y");
grid on