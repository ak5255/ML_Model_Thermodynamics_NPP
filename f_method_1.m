function y = f_method_1(b)

P_condenser_pressure = b(1);   
P_SG_Pressure = b(2);   
n_LPT = b(3);                    
n_HPT = b(3);                    
Q_thermal = b(4);

P_HPT = b(2);
P_LPT = 800; 			   


P_1 = P_SG_Pressure;
P_2 = P_HPT;
P_3 = P_LPT;
P_6 = P_condenser_pressure;


h_1 = XSteam('hV_p',P_1*0.01);
h_1_1 = XSteam('hL_p',P_1*0.01);
h_1_2 = h_1_1;
h_2 = h_1;
T_1 = XSteam('Tsat_p',P_1*0.01);


s_2 = XSteam('s_ph',P_2*0.01,h_2);
s_3_1 = s_2;
h_3_1 = XSteam('h_ps',P_3*0.01,s_3_1);
h_3 = h_2 - n_HPT*(h_2-h_3_1);


x_11 = XSteam('x_ph',P_3*0.01,h_3);
h_4 = XSteam('hV_p',P_3*0.01);
h_11 = XSteam('hL_p',P_3*0.01);


T_5 = T_1 - 20;
h_5 = XSteam('h_pT',P_3*0.01,T_5);
s_5 = XSteam('s_ph',P_3*0.01,h_5);
s_6_1 = s_5;
h_6_1 = XSteam('h_ps',P_6*0.01,s_6_1);
h_6 = h_5 - n_LPT*(h_5-h_6_1);


h_7 = XSteam('hL_p',P_6*0.01);


x_2 = (h_1-h_1_1)/((h_1-h_1_1)+x_11*(h_5-h_4));
h_9 = x_11*h_7 + h_11*(1-x_11);
h_10 = x_2*h_9 + h_1_2*(1-x_2);


w   = x_2*(h_2-h_3)+(x_2*x_11)*(h_5-h_6);
q   = h_1-h_10;
n_Efficiency = (w/q)*100;
W_HPT = (x_2*(h_2-h_3))/q*Q_thermal;
W_LPT = ((x_2*x_11)*(h_5-h_6))/q*Q_thermal;
q_Cond = x_2*x_11*(h_6-h_7)/q*Q_thermal;

y = [n_Efficiency, W_HPT, W_LPT, q_Cond];

end
