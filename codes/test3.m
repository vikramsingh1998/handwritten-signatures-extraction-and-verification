% Vertical Splitting

clear;
clc;
I =  imread('C:\Users\zkahmad\Desktop\Project_MITACS_UQTR_2019 (Vikram)\Database\Skel_img\Q-166_LVL160113059_RECTO_lic_s_res_skel.png');
[m n ] = size(I);

[Med Geo1 Geo2 Geo3] = GeoCentre_Vert(I);
figure
% f = figure('visible','off');
imshow(I)
hold on
plot(Geo1(1), Geo1(2),'*r')
plot(Geo2(1), Geo2(2),'*r')
plot(Geo3(1), Geo3(2),'*r')

P3(1:m,1) = Geo1(1);
P4 = [1:m]';
plot(P3,P4,'b')
 
P5 = [1:Geo1(1)]';
P6(1:Geo1(1),1) = Geo2(2);
plot(P5,P6,'b')

P7 = [Geo1(1):n]';
P8(1:numel(P7),1) = Geo3(2);
plot(P7,P8,'b')

I1 = I(1:Geo2(2),1:Geo1(1));

[Med1 Geo4 Geo5 Geo6] = GeoCentre_Vert(I1);

plot(Geo4(1), Geo4(2),'*r')
plot(Geo5(1), Geo5(2),'*r')
plot(Geo6(1), Geo6(2),'*r')

Q3(1:Geo2(2),1) = Geo4(1);
Q4 = [1:Geo2(2)]';
plot(Q3,Q4,'b')
 
Q5 = [1:Geo4(1)]';
Q6(1:Geo4(1),1) = Geo5(2);
plot(Q5,Q6,'b')

Q7 = [Geo4(1):Geo1(1)]';
Q8(1:numel(Q7)) = Geo6(2);
plot(Q7,Q8,'b')

I2 = I(1:Geo3(2),Geo1(1):end);

[Med2 Geo7 Geo8 Geo9] = GeoCentre_Vert(I2);

Geo7 = [Geo7(1)+Geo1(1), Geo7(2)];
Geo8 = [Geo8(1)+Geo1(1), Geo8(2)];
Geo9 = [Geo9(1)+Geo1(1), Geo9(2)];

plot(Geo7(1), Geo7(2),'*r')
plot(Geo8(1), Geo8(2),'*r')
plot(Geo9(1), Geo9(2),'*r')

R4 = [1:Geo3(2)]';
R3(1:numel(R4),1) = Geo7(1);
plot(R3,R4,'b')
 
R5 = [Geo1(1):Geo7(1)]';
R6(1:numel(R5),1) = Geo8(2);
plot(R5,R6,'b')

R7 = [Geo7(1):n]';
R8(1:numel(R7),1) = Geo9(2);
plot(R7,R8,'b')

I3 = I(Geo2(2):end,1:Geo1(1));

[Med3 Geo10 Geo11 Geo12] = GeoCentre_Vert(I3);

Geo10 = [Geo10(1), Geo10(2)+Geo2(2)];
Geo11 = [Geo11(1), Geo11(2)+Geo2(2)];
Geo12 = [Geo12(1), Geo12(2)+Geo2(2)];

plot(Geo10(1), Geo10(2),'*r')
plot(Geo11(1), Geo11(2),'*r')
plot(Geo12(1), Geo12(2),'*r')

S4 = [Geo2(2):m]';
S3(1:numel(S4),1) = Geo10(1);
plot(S3,S4,'b')
 
S5 = [1:Geo10(1)]';
S6(1:numel(S5),1) = Geo11(2);
plot(S5,S6,'b')

S7 = [Geo10(1):Geo1(1)]';
S8(1:numel(S7),1) = Geo12(2);
plot(S7,S8,'b')

I4 = I(Geo3(2):end,Geo1(1):end);

[Med4 Geo13 Geo14 Geo15] = GeoCentre_Vert(I4);

Geo13 = [Geo13(1)+Geo1(1), Geo13(2)+Geo3(2)];
Geo14 = [Geo14(1)+Geo1(1), Geo14(2)+Geo3(2)];
Geo15 = [Geo15(1)+Geo1(1), Geo15(2)+Geo3(2)];

plot(Geo13(1), Geo13(2),'*r')
plot(Geo14(1), Geo14(2),'*r')
plot(Geo15(1), Geo15(2),'*r')

T4 = [Geo3(2):n]';
T3(1:numel(T4),1) = Geo13(1);
plot(T3,T4,'b')
 
T5 = [Geo1(1):Geo13(1)]';
T6(1:numel(T5),1) = Geo14(2);
plot(T5,T6,'b')

T7 = [Geo13(1):n]';
T8(1:numel(T7),1) = Geo15(2);
plot(T7,T8,'b')

% 1
I5 = I(1:floor(Geo5(2)),1:floor(Geo4(1)));
Geo16 = GeoCentre(I5);
plot(Geo16(1), Geo16(2),'*r')

I6 = I(1:floor(Geo6(2)),floor(Geo4(1)):floor(Geo1(1)));
Geo17 = GeoCentre(I6);
Geo17 = [Geo17(1)+Geo4(1), Geo17(2)];
plot(Geo17(1), Geo17(2),'*r')

I7 = I(floor(Geo5(2)):floor(Geo2(2)),1:floor(Geo4(1)));
Geo18 = GeoCentre(I7);
Geo18 = [Geo18(1), Geo18(2)+Geo5(2)];
plot(Geo18(1), Geo18(2),'*r')

I8 = I(floor(Geo6(2)):floor(Geo2(2)),floor(Geo4(1)):floor(Geo1(1)));
Geo19 = GeoCentre(I8);
Geo19 = [Geo19(1)+Geo4(1), Geo19(2)+Geo6(2)];
plot(Geo19(1), Geo19(2),'*r')

% %2
I9 = I(1:floor(Geo8(2)),floor(Geo1(1)):floor(Geo7(1)));
Geo20 = GeoCentre(I9);
Geo20 = [Geo20(1)+Geo1(1), Geo20(2)];
plot(Geo20(1), Geo20(2),'*r')

I10 = I(1:floor(Geo9(2)),floor(Geo7(1):n));
Geo21 = GeoCentre(I10);
Geo21 = [Geo21(1)+Geo7(1), Geo21(2)];
plot(Geo21(1), Geo21(2),'*r')

I11 = I(floor(Geo8(2)):floor(Geo3(2)),floor(Geo1(1)):floor(Geo7(1)));
Geo22 = GeoCentre(I11);
Geo22 = [Geo22(1)+Geo1(1), Geo22(2)+Geo8(2)];
plot(Geo22(1), Geo22(2),'*r')

I12 = I(floor(Geo9(2)):floor(Geo3(2)),floor(Geo7(1)):n);
Geo23 = GeoCentre(I12);
Geo23 = [Geo23(1)+Geo7(1), Geo23(2)+Geo9(2)];
plot(Geo23(1), Geo23(2),'*r')

% %3
I13 = I(floor(Geo2(2)):floor(Geo11(2)),1:floor(Geo10(1)));
Geo24 = GeoCentre(I13);
Geo24 = [Geo24(1), Geo24(2)+Geo2(2)];
plot(Geo24(1), Geo24(2),'*r')

I14 = I(floor(Geo2(2)):floor(Geo12(2)),floor(Geo10(1)):floor(Geo1(1)));
Geo25 = GeoCentre(I14);
Geo25 = [Geo25(1)+Geo10(1), Geo25(2)+Geo2(2)];
plot(Geo25(1), Geo25(2),'*r')

I15 = I(floor(Geo11(2)):m,1:floor(Geo10(1)));
Geo26 = GeoCentre(I15);
Geo26 = [Geo26(1), Geo26(2)+Geo11(2)];
plot(Geo26(1), Geo26(2),'*r')

I16 = I(floor(Geo12(2)):m,floor(Geo10(1)):floor(Geo1(1)));
Geo27 = GeoCentre(I16);
Geo27 = [Geo27(1)+Geo10(1), Geo27(2)+Geo12(2)];
plot(Geo27(1), Geo27(2),'*r')

% %4
I17 = I(floor(Geo3(2)):floor(Geo14(2)),floor(Geo1(1)):floor(Geo13(1)));
Geo28 = GeoCentre(I17);
Geo28 = [Geo28(1)+Geo1(1), Geo28(2)+Geo3(2)];
plot(Geo28(1), Geo28(2),'*r')

I18 = I(floor(Geo3(2)):floor(Geo15(2)),floor(Geo13(1)):n);
Geo29 = GeoCentre(I18);
Geo29 = [Geo29(1)+Geo13(1), Geo29(2)+Geo3(2)];
plot(Geo29(1), Geo29(2),'*r')

I19 = I(floor(Geo14(2)):m,floor(Geo1(1)):floor(Geo13(1)));
Geo30 = GeoCentre(I19);
Geo30 = [Geo30(1)+Geo1(1), Geo30(2)+Geo14(2)];
plot(Geo30(1), Geo30(2),'*r')

I20 = I(floor(Geo15(2)):m,floor(Geo13(1)):n);
Geo31 = GeoCentre(I20);
Geo31 = [Geo31(1)+Geo13(1), Geo31(2)+Geo15(2)];
plot(Geo31(1), Geo31(2),'*r')

output_feat = [Geo1; Geo2; Geo3; Geo4; Geo5; Geo6; Geo7; Geo8; Geo9; Geo10; Geo11; Geo12; Geo13; Geo14; Geo15; Geo16; Geo17; Geo18; Geo19; Geo20; Geo21; Geo22; Geo23; Geo24; Geo25; Geo26; Geo27; Geo28; Geo29; Geo30; Geo31];
% if ~isempty(find(isnan(output_feat)))
% output_feat(nan) = 0;
% end
% saveas(gcf,'feature.png')