function y = f_method_2(b)

P_SG_Pressure = b(1);
P_LPT = 6000;                   
T_HPT = b(2);                    
T_LPT = b(2);                    
P_condenser_pressure = b(3);                    
n_LPT = b(4); 
n_HPT = b(4); 
Q_thermal= b(5);			   


P_1 = P_SG_Pressure;
P_2 = P_LPT;
P_4 = P_condenser_pressure;


h_1 = XSteam('h_pT',P_1*0.01,T_HPT);
s_1 = XSteam('s_pT',P_1*0.01,T_HPT);

s_2_1 = s_1;
h_2_1 = XSteam('h_ps',P_2*0.01,s_2_1);
h_2 = h_1 - n_HPT*(h_1-h_2_1);

h_3 = XSteam('h_pT',P_2*0.01,T_LPT);
s_3 = XSteam('s_pT',P_2*0.01,T_LPT);

s_4_1 = s_3;
h_4_1 = XSteam('h_ps',P_4*0.01,s_4_1);
h_4 = h_3 - n_LPT*(h_3-h_4_1);

h_5 = XSteam('hL_p',P_4*0.01);

w   = (h_1-h_2) + (h_3-h_4);
q   = (h_1-h_5) + (h_3-h_2);
n_Efficiency = (w/q)*100;
W_HPT = (h_1-h_2)/q*Q_thermal;
W_LPT = (h_3-h_4)/q*Q_thermal;
q_Cond = (h_4-h_5)/q*Q_thermal;

y = [W_HPT, W_LPT, q_Cond, n_Efficiency];

end
