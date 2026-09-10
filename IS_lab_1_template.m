clc
clear all

% Paveikslu nuskaitymas

% Obuoliai
A1 = imread('apple_04.jpg');
A2 = imread('apple_05.jpg');
A3 = imread('apple_06.jpg');
A4 = imread('apple_07.jpg');
A5 = imread('apple_11.jpg');
A6 = imread('apple_12.jpg');
A7 = imread('apple_13.jpg');
A8 = imread('apple_17.jpg');
A9 = imread('apple_19.jpg');

% Kriauses
P1 = imread('pear_01.jpg');
P2 = imread('pear_02.jpg');
P3 = imread('pear_03.jpg');
P4 = imread('pear_09.jpg');


% Pozymiu skaiciavimas

% x1 - spalva
% x2 - apvalumas

% Obuoliai
hsv_value_A1 = spalva_color(A1);
metric_A1 = apvalumas_roundness(A1);

hsv_value_A2 = spalva_color(A2);
metric_A2 = apvalumas_roundness(A2);

hsv_value_A3 = spalva_color(A3);
metric_A3 = apvalumas_roundness(A3);

hsv_value_A4 = spalva_color(A4);
metric_A4 = apvalumas_roundness(A4);

hsv_value_A5 = spalva_color(A5);
metric_A5 = apvalumas_roundness(A5);

hsv_value_A6 = spalva_color(A6);
metric_A6 = apvalumas_roundness(A6);

hsv_value_A7 = spalva_color(A7);
metric_A7 = apvalumas_roundness(A7);

hsv_value_A8 = spalva_color(A8);
metric_A8 = apvalumas_roundness(A8);

hsv_value_A9 = spalva_color(A9);
metric_A9 = apvalumas_roundness(A9);

% Kriauses
hsv_value_P1 = spalva_color(P1);
metric_P1 = apvalumas_roundness(P1);

hsv_value_P2 = spalva_color(P2);
metric_P2 = apvalumas_roundness(P2);

hsv_value_P3 = spalva_color(P3);
metric_P3 = apvalumas_roundness(P3);

hsv_value_P4 = spalva_color(P4);
metric_P4 = apvalumas_roundness(P4);


% Mokymo duomenys perceptronui. Naudojami 3 obuoliai ir 2 kriauses

x1 = [hsv_value_A1 hsv_value_A2 hsv_value_A3 ...
      hsv_value_P1 hsv_value_P2];

x2 = [metric_A1 metric_A2 metric_A3 ...
      metric_P1 metric_P2];

% Norimi atsakymai: 1 = obuolys, -1 = kriause

T = [1 1 1 -1 -1];


% Perceptrono pradiniai parametrai
% Atsitiktiniai svoriai
w1 = randn(1);
w2 = randn(1);

% Bias - poslinkis
b = randn(1);

% Mokymosi zingsnis
eta = 0.1;


for i = 1:5

    % Skaiciuojama suma
    v(i) = x1(i)*w1 + x2(i)*w2 + b;

    % Perceptrono atsakymas
    if v(i) > 0
        y(i) = 1;
    else
        y(i) = -1;
    end

    % Klaida
    error(i) = T(i) - y(i);

end

% Bendra klaida
e = sum(abs(error));

% Perceptrono mokymas. Mokoma tol, kol visu mokymo pavyzdziu klaida lygi 0

while e ~= 0

    for i = 1:5

        % Skaiciuojame dabartini atsakyma
        v(i) = x1(i)*w1 + x2(i)*w2 + b;

        if v(i) > 0
            y(i) = 1;
        else
            y(i) = -1;
        end

        % Momentine klaida
        error(i) = T(i) - y(i);

        % Atnaujiname parametrus
        w1 = w1 + eta*error(i)*x1(i);
        w2 = w2 + eta*error(i)*x2(i);
        b = b + eta*error(i);

    end

    % Po atnaujinimo dar karta patikriname visus 5 pavyzdzius
    for i = 1:5

        v(i) = x1(i)*w1 + x2(i)*w2 + b;

        if v(i) > 0
            y(i) = 1;
        else
            y(i) = -1;
        end

        error(i) = T(i) - y(i);

    end

    % Nauja bendra klaida
    e = sum(abs(error));

end

% Perceptrono rezultatai
disp('Perceptrono mokymas baigtas')
disp('Bendra mokymo klaida:')
disp(e)

disp('w1:')
disp(w1)

disp('w2:')
disp(w2)

disp('b:')
disp(b)


%% 2 uzd. Perceptrono testavimas

% Testuojami paveikslai, kurie nebuvo naudojami mokymui

test_x1 = [hsv_value_A4 hsv_value_A5 hsv_value_A6 ...
           hsv_value_A7 hsv_value_A8 hsv_value_A9 ...
           hsv_value_P3 hsv_value_P4];

test_x2 = [metric_A4 metric_A5 metric_A6 ...
           metric_A7 metric_A8 metric_A9 ...
           metric_P3 metric_P4];

% Teisingi atsakymai
test_T = [1 1 1 1 1 1 -1 -1];

for i = 1:8

    % Naudojami jau ismokyti w1, w2 ir b. Testavimo metu svoriai nebeatnaujinami

    test_v(i) = test_x1(i)*w1 + test_x2(i)*w2 + b;

    if test_v(i) > 0
        test_y(i) = 1;
    else
        test_y(i) = -1;
    end

    % Testavimo klaida
    test_error(i) = test_T(i) - test_y(i);

end

% Bendra testavimo klaida
test_e = sum(abs(test_error));

disp('Perceptrono testavimo rezultatai:')
disp(test_y)

disp('Bendra perceptrono testavimo klaida:')
disp(test_e)

%% 3 uzd Papildoma uzduotis Naive Bayes

disp('Naive Bayes klasifikavimo pradzia')

% Atskiriame obuoliu ir kriausiu mokymo duomenis
apple_x1 = [hsv_value_A1 hsv_value_A2 hsv_value_A3];
apple_x2 = [metric_A1 metric_A2 metric_A3];

pear_x1 = [hsv_value_P1 hsv_value_P2 hsv_value_P3];
pear_x2 = [metric_P1 metric_P2 metric_P3];

% Klasiu tikimybes
P_apple = 3/6;
P_pear = 3/6;

% Pozymiu vidurkiai
mean_apple_x1 = mean(apple_x1);
mean_apple_x2 = mean(apple_x2);

mean_pear_x1 = mean(pear_x1);
mean_pear_x2 = mean(pear_x2);

% Standartiniai nuokrypiai
std_apple_x1 = std(apple_x1,1);
std_apple_x2 = std(apple_x2,1);

std_pear_x1 = std(pear_x1,1);
std_pear_x2 = std(pear_x2,1);


% Testavimo duomenys


NB_x1 = [hsv_value_A4 hsv_value_A5 hsv_value_A6 hsv_value_A7 hsv_value_A8 hsv_value_A9 hsv_value_P4];

NB_x2 = [metric_A4 metric_A5 metric_A6 metric_A7 metric_A8 metric_A9 metric_P4];

% Teisingi atsakymai
NB_T = [1 1 1 1 1 1 -1];


% Testavimas
for i = 1:7

    % Tikimybe obuoliui pagal spalva
    pA1 = (1/(sqrt(2*pi)*std_apple_x1))*exp(-((NB_x1(i)-mean_apple_x1)^2)/(2*std_apple_x1^2));

    % Tikimybe obuoliui pagal apvaluma
    pA2 = (1/(sqrt(2*pi)*std_apple_x2))*exp(-((NB_x2(i)-mean_apple_x2)^2)/(2*std_apple_x2^2));

    % Tikimybe kriausei pagal spalva
    pP1 = (1/(sqrt(2*pi)*std_pear_x1))*exp(-((NB_x1(i)-mean_pear_x1)^2)/(2*std_pear_x1^2));

    % Tikimybe kriausei pagal apvaluma
    pP2 = (1/(sqrt(2*pi)*std_pear_x2))*exp(-((NB_x2(i)-mean_pear_x2)^2)/(2*std_pear_x2^2));

    % Bendra tikimybe
    P_A = P_apple*pA1*pA2;
    P_P = P_pear*pP1*pP2;

    % Pasirenkame didesne tikimybe
    if P_A > P_P
        NB_y(i) = 1;
    else
        NB_y(i) = -1;
    end

    % Klaida
    NB_error(i) = NB_T(i) - NB_y(i);

end

% Bendra klaida
NB_e = sum(abs(NB_error));

% Rezultatai
disp('Teisingi atsakymai:')
disp(NB_T)

disp('Naive Bayes atsakymai:')
disp(NB_y)

disp('Klaidos:')
disp(NB_error)

disp('Bendra klaida:')
disp(NB_e)