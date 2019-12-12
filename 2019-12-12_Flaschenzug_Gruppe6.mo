package Flaschenzug_Gruppe6

  class UsersGuide "User's Guide"
  
   annotation (Documentation(info = "<html>
  <p>
  Bibliothek zur Erstellung eines Flaschenzugs im Rahmen des Masterstudiums Mechatronische Systementwicklung der Hochschule Pforzheim
  Die Bibliothek zur Erstellung eines Flaschenzugs besteht aus...
  
  </p>
  
  </html>"),
      Icon(coordinateSystem(initialScale = 0.1), graphics = {Rectangle(lineColor = {200, 200, 200}, fillColor = {248, 248, 248}, fillPattern = FillPattern.HorizontalCylinder, extent = {{-100, -100}, {100, 100}}, radius = 25), Ellipse(fillColor = {75, 138, 73},pattern = LinePattern.None, fillPattern = FillPattern.Solid, extent = {{-97, 97}, {97, -97}}, endAngle = 360), Ellipse(origin = {7.5, 56.5}, fillColor = {255, 255, 255}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, extent = {{-12.5, -12.5}, {12.5, 12.5}}, endAngle = 360), Polygon(origin = {3.83, -15}, fillColor = {255, 255, 255}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, points = {{-15.833, 20}, {-15.833, 30}, {14.167, 40}, {24.167, 20}, {4.167, -30}, {14.167, -30}, {24.167, -30}, {24.167, -40}, {-5.833, -50}, {-15.833, -30}, {4.167, 20}, {-5.833, 20},  {-15.833, 20}}, smooth = Smooth.Bezier)}));
  
  end UsersGuide;
  package Connectoren
    connector SeilConnect
      flow Modelica.SIunits.Force Fz;
      Modelica.SIunits.Length s;
      Modelica.SIunits.Length s_max;
      flow Real nGes;
      flow Real nGes2;
      Modelica.SIunits.Length h;
      Modelica.SIunits.Velocity v_Masse;
      Modelica.SIunits.Force Fg;
      
      annotation(
        Icon(graphics = {Ellipse(fillColor = {175, 117, 0}, fillPattern = FillPattern.CrossDiag, lineThickness = 0.5, extent = {{-98, 98}, {98, -98}}, endAngle = 360)}, coordinateSystem(initialScale = 0.1)));
    end SeilConnect;

    connector SpannungsPort
      Modelica.SIunits.Voltage U "Versorgungsspannung";
      annotation(
        Icon(coordinateSystem(initialScale = 0.1), graphics = {Ellipse(origin = {-1, 1}, fillColor = {255, 0, 0}, fillPattern = FillPattern.CrossDiag, extent = {{-99, 99}, {99, -99}}, endAngle = 360)}));
    end SpannungsPort;

    connector SeilPort
      flow Modelica.SIunits.Torque M_L;
      Modelica.SIunits.AngularVelocity w;
      Modelica.SIunits.Length r;
      Modelica.SIunits.Voltage U;
      Modelica.SIunits.Torque M_E;
      Real d;
      Modelica.SIunits.Force Fz;
      Modelica.SIunits.Force Fg;
      Modelica.SIunits.Length s;
      Modelica.SIunits.Length h;
      Modelica.SIunits.Velocity v_Masse;
      Modelica.SIunits.Velocity v_Motor;
      
      annotation(
        Icon(coordinateSystem(initialScale = 0.1), graphics = {Ellipse(fillColor = {255, 255, 127}, fillPattern = FillPattern.CrossDiag, extent = {{-98, 98}, {98, -98}}, endAngle = 360)}));
    end SeilPort;

    connector ScopePort
      Modelica.SIunits.Torque M_E;
      Modelica.SIunits.Torque M_L;
      Modelica.SIunits.Force Fz;
      Modelica.SIunits.Force Fg;
      Modelica.SIunits.Length s;
      Modelica.SIunits.Length h;
      Modelica.SIunits.Velocity v_Masse;
      Modelica.SIunits.Velocity v_Motor;
      annotation(
        Icon(graphics = {Ellipse(fillColor = {173, 173, 173}, fillPattern = FillPattern.CrossDiag, extent = {{-98, 98}, {98, -98}}, endAngle = 360)}));
    end ScopePort;
    annotation(
      Icon(graphics = {Rectangle( lineColor = {200, 200, 200}, fillColor = {248, 248, 248}, fillPattern = FillPattern.HorizontalCylinder, extent = {{-100, -100}, {100, 100}}, radius = 25), Polygon(origin = {-10.1, 5.52}, rotation = 45, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid, points = {{-15, 87.273}, {15, 87.273}, {20, 82.273}, {20, 27.273}, {10, 17.273}, {10, 7.273}, {20, 2.373}, {20, -2.727}, {5, -2.727}, {5, -77.727}, {10, -87.727}, {5, -112.727}, {-5, -112.727}, {-10, -87.727}, {-5, -77.727}, {-5, -2.727}, {-20, -2.727}, {-20, 2.273}, {-10, 7.273}, {-10, 17.273}, {-20, 27.273}, {-20, 82.273}, {-15, 87.273}})}, coordinateSystem(initialScale = 0.1)),
      Diagram,
      __OpenModelica_commandLineOptions = "");
  end Connectoren;

  model Flaschenzug_Komponenten
    model Masse
      Flaschenzug_Gruppe6.Connectoren.SeilConnect seilConnect1 annotation(
        Placement(visible = true, transformation(origin = {0, 70}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {5.55112e-15, 86}, extent = {{-14, -14}, {14, 14}}, rotation = 0)));
      constant Real g_n = Modelica.Constants.g_n;
      parameter Modelica.SIunits.Mass m = 1;
      parameter Modelica.SIunits.Length s_max = 0.1;
      Real n = if abs(seilConnect1.nGes) < 1 then 1 else abs(seilConnect1.nGes);
      //Null Rollen entspricht dem Zustand mit einer Rolle
      Modelica.SIunits.Length h "Hubhöhe der Masse";
      Modelica.SIunits.Force Fg "Gewichtskraft der angehängten Masse";
      Modelica.SIunits.Velocity v_Masse "Hubgeschwindigkeit der Masse";
      Modelica.SIunits.Acceleration a "Hubbeschleunigung der Masse";
    equation
      seilConnect1.s_max = s_max;
      seilConnect1.nGes2 = 0;
      seilConnect1.Fz * n = m * g_n;
      Fg = m * g_n;
      h = seilConnect1.s / n;
      h = seilConnect1.h;
      Fg = seilConnect1.Fg;
      der(h) = v_Masse;
      der(v_Masse) = a;
      v_Masse = seilConnect1.v_Masse;
      annotation(
        Icon(graphics = {Ellipse(origin = {-10, 48}, fillColor = {130, 130, 130}, fillPattern = FillPattern.Solid, lineThickness = 0.5, extent = {{-40, 40}, {60, -60}}, endAngle = 360), Ellipse(origin = {10, 30}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid, lineThickness = 0.5, extent = {{-40, 40}, {20, -22}}, endAngle = 360), Text(origin = {-74, -90}, extent = {{-22, 30}, {172, -10}}, textString = "Masse = %m kg"), Polygon(origin = {0, -10}, fillColor = {130, 130, 130}, fillPattern = FillPattern.Solid, lineThickness = 0.5, points = {{-60, 50}, {60, 50}, {100, -50}, {-100, -50}, {-60, 50}})}, coordinateSystem(initialScale = 0.1)));
    end Masse;

    model Scope "Anzeige der relevanten Daten"
    
    Flaschenzug_Gruppe6.Connectoren.ScopePort scopePort1 annotation(
        Placement(visible = true, transformation(origin = {-4, -52}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-44, -66}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    
      input Modelica.SIunits.Torque M_E "Elektrisches Drehmoment";
      input Modelica.SIunits.Torque M_L "Lastmoment";
      input Modelica.SIunits.Force Fz "Aufgebrachte Kraft der E-Maschine";
      input Modelica.SIunits.Force Fg "Gewichtskraft der angehängten Masse";
      input Modelica.SIunits.Length s "Seilweg an der Seiltrommel";
      input Modelica.SIunits.Length h "Hubhöhe der Masse";
      input Modelica.SIunits.Velocity v_Motor "Geschwindigkeit des Motors";
      input Modelica.SIunits.Velocity v_Masse "Hubgeschwindigkeit der Masse";
      
    equation
      scopePort1.M_E = M_E;
      scopePort1.M_L = M_L;
      scopePort1.Fz = Fz;
      scopePort1.Fg = Fg;
      scopePort1.s = s;
      scopePort1.h = h;
      scopePort1.v_Motor = v_Motor;
      scopePort1.v_Masse = v_Masse;
      
      annotation(
        Icon(graphics = {Rectangle(origin = {10, 0}, fillColor = {173, 173, 173}, fillPattern = FillPattern.Solid, extent = {{-70, 80}, {50, -80}}), Rectangle(origin = {20, 52}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid, extent = {{-70, 20}, {30, -20}}), Text(origin = {-29, 59}, fillColor = {173, 173, 173}, fillPattern = FillPattern.Solid, extent = {{-33, 7}, {87, -19}}, textString = "Scope")}, coordinateSystem(extent = {{-61, -81}, {61, 81}})),
        Diagram(coordinateSystem(extent = {{-61, -81}, {61, 81}})),
        __OpenModelica_commandLineOptions = "");
    end Scope;

    package Antrieb
      model Antrieb "Elektrischer Gleichstrommaschine"
                             //Parameter aus der Spannungsquelle
        parameter Modelica.SIunits.Voltage U = 24 "Versorgungsspannung" annotation(
        Dialog(tab = "Spannungsquelle"));
        //Parameter aus dem Motor
        parameter Real Jgm (final unit = "kg*m^2") = 0.0000306 "Motorträgheitsmoment" annotation(
        Dialog(tab = "Motor"));
        parameter Real d = -1 "Drehrichtung des Motors" annotation(
        Dialog(tab = "Motor"));
        parameter Modelica.SIunits.Current Ia_rat = 6.7 "Erregerstrom" annotation(
        Dialog(tab = "Motor"));
        parameter Modelica.SIunits.Current Ia_sat = 0.1 "Sättigungsstrom" annotation(
        Dialog(tab = "Motor"));
        parameter Real crem = 1.06 "Remanenzfaktor" annotation(
        Dialog(tab = "Motor"));
        parameter Real csat = 1 "Sättigungskonstante" annotation(
        Dialog(tab = "Motor"));
        parameter Modelica.SIunits.ElectricalTorqueConstant ke_rat = 0.5 "Nennwert von ke" annotation(
        Dialog(tab = "Motor"));
        parameter Modelica.SIunits.Resistance R_fw = 1 "Feldwiderstand" annotation(
        Dialog(tab = "Motor"));
        parameter Modelica.SIunits.Resistance R_a = 1 "Ankerwiderstand" annotation(
        Dialog(tab = "Motor"));
        parameter Modelica.SIunits.Inductance L_fw = 1e-4 "Feldinduktivitaet" annotation(
        Dialog(tab = "Motor"));
        parameter Modelica.SIunits.Inductance L_a = 1e-4 "Ankerinduktivitaet" annotation(
        Dialog(tab = "Motor"));
        parameter Modelica.SIunits.Voltage U_b = 0.5 "Bürstenspannung" annotation(
        Dialog(tab = "Motor"));
        //Parameter aus der Seiltrommel
        parameter Modelica.SIunits.Length r = 0.1 "Seiltrommelradius" annotation(
        Dialog(tab = "Seiltrommel"));
       /*                        
        //Zuweisung der Parameter aus der Spannungsquelle
        Antrieb_Komponenten.Spannungsquelle spannungsquelle(U = U);
        //Zuweisung der Parameter aus dem Motor
        Antrieb_Komponenten.Motor motor(
        Jgm = Jgm, 
        d = d, 
        Ia_rat = Ia_rat, 
        Ia_sat = Ia_sat, 
        crem = crem, 
        csat = csat, 
        ke_rat = ke_rat, 
        R_fw = R_fw, 
        R_a = R_a, 
        L_fw = L_fw,
        L_a = L_a, 
        U_b = U_b);
        //Zuweisung der Parameter aus der Seiltrommel
        Antrieb_Komponenten.Seiltrommel seiltrommel(r = r);
      */                
                            
        Flaschenzug_Gruppe6.Flaschenzug_Komponenten.Antrieb.Antrieb_Komponenten.Spannungsquelle spannungsquelle1 annotation(
          Placement(visible = true, transformation(origin = {-60, -20}, extent = {{-8, -7.3}, {8, 7.3}}, rotation = 0)));
  Flaschenzug_Gruppe6.Flaschenzug_Komponenten.Antrieb.Antrieb_Komponenten.Motor motor1 annotation(
          Placement(visible = true, transformation(origin = {-24.5469, 1.46252}, extent = {{-25.7531, -13.9625}, {25.7531, 15.2036}}, rotation = 0)));
  Flaschenzug_Gruppe6.Flaschenzug_Komponenten.Antrieb.Antrieb_Komponenten.Seiltrommel seiltrommel1 annotation(
          Placement(visible = true, transformation(origin = {36, 4}, extent = {{-18.5, -18.5}, {18.5, 16.7588}}, rotation = 0)));
  Flaschenzug_Gruppe6.Connectoren.ScopePort scopePort1 annotation(
          Placement(visible = true, transformation(origin = {-28, 18}, extent = {{-4, -4}, {4, 4}}, rotation = 0), iconTransformation(origin = {-40, 22}, extent = {{-6, -6}, {6, 6}}, rotation = 0)));
  Flaschenzug_Gruppe6.Connectoren.SeilConnect seilConnect1 annotation(
          Placement(visible = true, transformation(origin = {48, -20}, extent = {{-4, -4}, {4, 4}}, rotation = 0), iconTransformation(origin = {57, -21}, extent = {{-7, -7}, {7, 7}}, rotation = 0)));
      equation
        connect(motor1.scopePort1, scopePort1) annotation(
          Line(points = {{-44, 14}, {-30, 14}, {-30, 18}, {-28, 18}}));
        connect(seiltrommel1.seilConnect1, seilConnect1) annotation(
          Line(points = {{46, -12}, {48, -12}, {48, -20}, {48, -20}}));
        connect(motor1.seilPort1, seiltrommel1.seilPort1) annotation(
          Line(points = {{-2, 6}, {20, 6}, {20, 4}, {20, 4}}));
        connect(spannungsquelle1.SpannungsPort1, motor1.SpannungsPort1) annotation(
          Line(points = {{-54, -20}, {-44, -20}, {-44, -2}, {-44, -2}}));
        annotation(
          Icon(graphics = {Rectangle(origin = {-12, -26}, fillPattern = FillPattern.Solid, extent = {{-30, -2}, {30, 2}}), Rectangle(origin = {-30, -19}, fillColor = {131, 131, 131}, fillPattern = FillPattern.Solid, extent = {{-4, 5}, {4, -5}}), Rectangle(origin = {6, -19}, fillColor = {131, 131, 131}, fillPattern = FillPattern.Solid, extent = {{-4, 5}, {4, -5}}), Rectangle(origin = {-12, 6}, fillColor = {190, 190, 190}, fillPattern = FillPattern.Horizontal, extent = {{-30, 20}, {30, -20}}), Rectangle(origin = {28, 6}, fillColor = {165, 165, 165}, fillPattern = FillPattern.Solid, extent = {{-2, 20}, {2, -20}}), Rectangle(origin = {64, 6}, fillColor = {165, 165, 165}, fillPattern = FillPattern.Solid, extent = {{-2, 20}, {2, -20}}), Rectangle(origin = {46, 7}, fillColor = {173, 173, 173}, fillPattern = FillPattern.Solid, extent = {{-20, 13}, {20, -13}}), Rectangle(origin = {22, 7}, fillPattern = FillPattern.Solid, extent = {{-4, 3}, {4, -3}}), Line(origin = {42.88, 1.68}, points = {{-12.8751, -7.67949}, {-4.87507, 18.3205}, {-4.87507, -7.67949}, {5.12493, 18.3205}, {5.12493, -7.67949}, {13.1249, 18.3205}, {13.1249, -17.6795}}, color = {175, 117, 0}, thickness = 0.5), Rectangle(origin = {-59, -23}, fillColor = {220, 220, 220}, fillPattern = FillPattern.Solid, extent = {{-7, 7}, {5, -5}}), Ellipse(origin = {-60, -22}, extent = {{-4, 4}, {4, -4}}, endAngle = 360), Line(origin = {-51, -15.82}, points = {{-9, -6}, {1, -6}, {1, 6}, {9, 6}, {9, 6}}, thickness = 0.5)}, coordinateSystem(extent = {{-70, -30}, {70, 29}}, initialScale = 0.1)),
          Diagram(coordinateSystem(extent = {{-70, -30}, {70, 29}})),
          __OpenModelica_commandLineOptions = "");
      end Antrieb;

      class Antrieb_Komponenten
        model Motor
          Flaschenzug_Gruppe6.Connectoren.SpannungsPort SpannungsPort1 annotation(
            Placement(visible = true, transformation(origin = {-60, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-63, -13}, extent = {{-9, -9}, {9, 9}}, rotation = 0)));
          Flaschenzug_Gruppe6.Connectoren.SeilPort seilPort1 annotation(
            Placement(visible = true, transformation(origin = {60, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {70, 14}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
          Flaschenzug_Gruppe6.Connectoren.ScopePort scopePort1 annotation(
            Placement(visible = true, transformation(origin = {-66, 40}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-64, 38}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
          parameter Real Jgm = 0.0000306 "Motorträgheitsmoment";
          parameter Real d = -1 "Drehrichtung";
          parameter Modelica.SIunits.Current Ia_rat = 6.7 "Erregerstrom";
          parameter Modelica.SIunits.Current Ia_sat = 0.1 "Sättigungsstrom";
          parameter Real crem = 1.06 "Remanenzfaktor";
          parameter Real csat = 1 "Sättigungskonstante";
          parameter Modelica.SIunits.ElectricalTorqueConstant ke_rat = 0.5 "Nennwert von ke";
          parameter Modelica.SIunits.Resistance R_fw = 1 "Feldwiderstand";
          parameter Modelica.SIunits.Resistance R_a = 1 "Ankerwiderstand";
          parameter Modelica.SIunits.Inductance L_fw = 1e-4 "Feldinduktivitaet";
          parameter Modelica.SIunits.Inductance L_a = 1e-4 "Ankerinduktivitaet";
          parameter Modelica.SIunits.Voltage U_b = 0.5 "Bürstenspannung";
          Modelica.SIunits.ElectricalTorqueConstant ke_rem;
          //Hilfsvariable von ke
          Real delta_ke_sat = ke_rat * (1 - crem) / (1 - exp(-1)) * exp(-csat) / Ia_rat;
          //Hilfsvariable 2 von ke;
          Modelica.SIunits.ElectricalTorqueConstant ke;
          Modelica.SIunits.RotationalDampingConstant kt;
          Modelica.SIunits.Current I;
          Modelica.SIunits.Voltage Ug;
          Modelica.SIunits.Torque M_eff;
          // Real P; //Leistung
          output Modelica.SIunits.AngularVelocity w;
          Modelica.SIunits.Torque M_E;
          input Modelica.SIunits.Torque M_L;
        equation
//Berechnung des Stroms
          kt = ke * 60 / (2 * Modelica.Constants.pi);
          ke = if abs(I) <= Ia_sat then ke_rem + ke_rat * (1 - crem) / (1 - exp(-1)) * (1 - exp(-I / Ia_rat)) else ke_rat * (1 - crem) / (1 - exp(-1)) + ke_rem + delta_ke_sat * (I - Ia_rat);
          ke_rem = crem * ke_rat;
          Ug = ke * w * 2 * Modelica.Constants.pi;
          SpannungsPort1.U = I * (R_a + R_fw) + (L_fw + L_a) * der(I) + Ug + 2 * U_b;
//Berechnung des Moments
          M_E = kt * I;
          M_L = seilPort1.M_L;
          M_E - M_L = (Jgm + M_L * seilPort1.r) * der(w);
          M_eff = M_E - M_L;
//seilPort1.w = if SpannungsPort1.U == 0 then 0 else d*w;
          seilPort1.w = d * w;
          SpannungsPort1.U = seilPort1.U;
          M_E = seilPort1.M_E;
          seilPort1.d = d;
          
          M_E = scopePort1.M_E;
          M_L = scopePort1.M_L;
          seilPort1.Fz = scopePort1.Fz;
          seilPort1.Fg = scopePort1.Fg;
          seilPort1.s = scopePort1.s;
          seilPort1.h = scopePort1.h;
          seilPort1.v_Motor = scopePort1.v_Motor;
          seilPort1.v_Masse = scopePort1.v_Masse;
          annotation(
            Icon(coordinateSystem(extent = {{-83, -45}, {83, 49}}), graphics = {Rectangle(origin = {-8, -38}, fillPattern = FillPattern.Solid, extent = {{-60, 6}, {60, -6}}), Rectangle(origin = {-38, -24}, fillColor = {131, 131, 131}, fillPattern = FillPattern.Solid, extent = {{-10, 8}, {10, -8}}), Rectangle(origin = {22, -24}, fillColor = {131, 131, 131}, fillPattern = FillPattern.Solid, extent = {{10, 8}, {-10, -8}}), Rectangle(origin = {-8, 14}, fillColor = {190, 190, 190}, fillPattern = FillPattern.Horizontal, extent = {{-60, 30}, {60, -30}}), Rectangle(origin = {62, 14}, fillPattern = FillPattern.Solid, extent = {{10, 10}, {-10, -10}})}),
            Diagram(coordinateSystem(extent = {{-83, -45}, {83, 49}})),
            __OpenModelica_commandLineOptions = "");
        end Motor;

        model Seiltrommel
          Flaschenzug_Gruppe6.Connectoren.SeilPort seilPort1 annotation(
            Placement(visible = true, transformation(origin = {0, 58}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-72, 0}, extent = {{-12, -12}, {12, 12}}, rotation = 0)));
          Flaschenzug_Gruppe6.Connectoren.SeilConnect seilConnect1 annotation(
            Placement(visible = true, transformation(origin = {-60, -20}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {48, -72}, extent = {{-12, -12}, {12, 12}}, rotation = 0)));
          parameter Modelica.SIunits.Length r = 0.1 "Radius";
          parameter Modelica.SIunits.AngularVelocity w_max = 12000 "max. Drehzahl";
          input Modelica.SIunits.Force Fz "Aufgebrachte Kraft der E-Maschine";
          Real s_tr;
          output Modelica.SIunits.Velocity v_Motor "Geschwindigkeit des Motors";
          output Modelica.SIunits.Force F_za;
          
          Modelica.SIunits.Length s;
          Modelica.SIunits.Length h;
          Modelica.SIunits.Force Fg;
          Modelica.SIunits.Velocity v_Masse;
          
        equation
          seilConnect1.nGes = 0;
          Fz + seilConnect1.Fz = 0;
          seilPort1.r = r;
          F_za = -seilConnect1.Fz * ((-abs(seilPort1.w) / w_max) + 1);
          v_Motor = seilPort1.w * r;
//s_help = s_max*(1-exp(seilConnect1.s));
          der(s) = v_Motor;
          seilConnect1.s = seilPort1.d * (-seilConnect1.s_max) * seilConnect1.nGes2 * (1 - exp(-abs(s_tr)));
//seilConnect1.s = s_max*(1-exp(seilConnect1.s));
          seilPort1.M_L = if seilPort1.U <= 0 then seilPort1.M_E else -F_za * r;
//v = if seilPort1.U == 0 then 0 else if seilPort1.U <= 0 then -seilPort1.w * r else seilPort1.w;
//M_L * seilPort1.w - F_z * v =0;
          v_Motor = seilPort1.v_Motor;
          Fz = seilPort1.Fz;
          s = seilConnect1.s;
          s = seilPort1.s;
          h = seilConnect1.h;
          h = seilPort1.h;
          Fg = seilConnect1.Fg;
          Fg = seilPort1.Fg;
          v_Masse = seilConnect1.v_Masse;
          v_Masse = seilPort1.v_Masse;
          annotation(
            Icon(graphics = {Rectangle(origin = {-46, -32}, rotation = 90, fillColor = {201, 201, 201}, fillPattern = FillPattern.Solid, extent = {{-40, 4}, {108, -16}}), Rectangle(origin = {66, -18}, rotation = 90, fillColor = {201, 201, 201}, fillPattern = FillPattern.Solid, extent = {{-54, 4}, {94, -16}}), Rectangle(origin = {20, -8}, rotation = 90, fillColor = {201, 201, 201}, fillPattern = FillPattern.Solid, extent = {{-40, 50}, {56, -42}}), Line(origin = {0.527141, -30.82}, rotation = 90, points = {{-17.5459, 29.8937}, {78.4541, 9.89366}, {-17.5459, 9.89366}, {78.4541, -10.1063}, {-17.5459, -10.1063}, {78.4541, -30.1063}, {-17.5459, -30.1063}}, color = {175, 117, 0}, thickness = 1.75), Rectangle(origin = {-56, -9}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid, extent = {{-18, 23}, {6, -5}}), Line(origin = {41.08, -7.43}, points = {{-8.9333, -40.5735}, {7.0667, 55.4265}, {9.0667, -56.5735}}, color = {175, 117, 0}, thickness = 1.5)}, coordinateSystem(extent = {{-85, -85}, {85, 77}})),
            Diagram(coordinateSystem(extent = {{-85, -85}, {85, 77}})),
            __OpenModelica_commandLineOptions = "");
        end Seiltrommel;

        model Spannungsquelle
          parameter Modelica.SIunits.Voltage U = 24 "Versorgungsspannung";
          Flaschenzug_Gruppe6.Connectoren.SpannungsPort SpannungsPort1 annotation(
            Placement(visible = true, transformation(origin = {70, -26}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {68, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        equation
          SpannungsPort1.U = U;
          annotation(
            Icon(graphics = {Rectangle(origin = {-2, 0}, fillColor = {220, 220, 220}, fillPattern = FillPattern.Solid, lineThickness = 1, extent = {{-70, 70}, {70, -70}}), Ellipse(origin = {-20, 42}, fillColor = {201, 201, 201}, fillPattern = FillPattern.Solid, lineThickness = 1, extent = {{-40, 20}, {80, -100}}, endAngle = 360), Ellipse(origin = {-27, 1}, fillPattern = FillPattern.Solid, extent = {{-11, 11}, {11, -11}}, endAngle = 360), Ellipse(origin = {23, 1}, fillPattern = FillPattern.Solid, extent = {{-11, 11}, {11, -11}}, endAngle = 360)}, coordinateSystem(extent = {{-80, -73}, {80, 73}})),
            Diagram(coordinateSystem(extent = {{-80, -73}, {80, 73}})),
            __OpenModelica_commandLineOptions = "");
        end Spannungsquelle;
        annotation(
          Icon(graphics = {Rectangle(lineColor = {200, 200, 200}, fillColor = {248, 248, 248}, fillPattern = FillPattern.Solid, extent = {{-100, -100}, {100, 100}}, radius = 25), Rectangle(fillColor = {95, 95, 95}, fillPattern = FillPattern.CrossDiag, extent = {{-12, 90}, {12, -90}}), Rectangle(rotation = 45, fillColor = {95, 95, 95}, fillPattern = FillPattern.CrossDiag, extent = {{-12, 90}, {12, -90}}), Rectangle(rotation = 90, fillColor = {95, 95, 95}, fillPattern = FillPattern.CrossDiag, extent = {{-12, 90}, {12, -90}}), Rectangle(rotation = -45, fillColor = {95, 95, 95}, fillPattern = FillPattern.CrossDiag, extent = {{-12, 90}, {12, -90}}), Ellipse(fillColor = {95, 95, 95}, fillPattern = FillPattern.CrossDiag, extent = {{-75, 75}, {75, -75}}, endAngle = 360), Ellipse(fillColor = {248, 248, 248}, fillPattern = FillPattern.Solid, extent = {{-20, 20}, {20, -20}}, endAngle = 360)}, coordinateSystem(initialScale = 0.1)));
      end Antrieb_Komponenten;
      annotation(
        Icon(graphics = {Rectangle(lineColor = {200, 200, 200}, fillColor = {248, 248, 248}, fillPattern = FillPattern.HorizontalCylinder, extent = {{-100, -100}, {100, 100}}, radius = 25), Rectangle(origin = {-74, -75}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid, extent = {{-14, 14}, {14, -14}}), Ellipse(origin = {-74, -75}, extent = {{-11, 11}, {11, -11}}, endAngle = 360), Rectangle(origin = {0, -38}, fillPattern = FillPattern.Solid, extent = {{-46, 4}, {26, -2}}), Rectangle(origin = {-32, -27}, fillColor = {200, 200, 200}, fillPattern = FillPattern.Solid, extent = {{-8, 7}, {8, -7}}), Rectangle(origin = {12, -27}, fillColor = {200, 200, 200}, fillPattern = FillPattern.Solid, extent = {{-8, 7}, {8, -7}}), Rectangle(origin = {-11, 0}, fillColor = {200, 200, 200}, fillPattern = FillPattern.Horizontal, extent = {{-39, -20}, {39, 20}}), Rectangle(origin = {34, -1}, fillPattern = FillPattern.Solid, extent = {{-6, 7}, {6, -7}}), Line(origin = {-62, -33.2791}, points = {{12, 19}, {-12, 19}, {-12, -41}}, thickness = 0.5), Rectangle(origin = {43, 0}, fillColor = {200, 200, 200}, fillPattern = FillPattern.Solid, extent = {{-3, 30}, {3, -30}}), Rectangle(origin = {91, 0}, fillColor = {200, 200, 200}, fillPattern = FillPattern.Solid, extent = {{-3, 30}, {3, -30}}), Rectangle(origin = {67, -1}, fillColor = {200, 200, 200}, fillPattern = FillPattern.Solid, extent = {{-21, 21}, {21, -21}}), Line(origin = {62.9, -10.36}, points = {{-16.8978, -11.6374}, {-6.89779, 30.3626}, {-6.89779, -11.6374}, {5.10221, 30.3626}, {5.10221, -11.6374}, {17.1022, 30.3626}, {17.1022, -29.6374}, {17.1022, -29.6374}}, color = {175, 117, 0}, thickness = 0.6)}),
        Diagram,
        __OpenModelica_commandLineOptions = "");
    end Antrieb;

    model Anschlussarten
      model Invertierter_Anschluss
      Flaschenzug_Gruppe6.Connectoren.SeilConnect seilConnect1 annotation(
          Placement(visible = true, transformation(origin = {-92, 38}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-90, 40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      
        parameter Integer n = 1 "Anzahl der Rollen";
        parameter Real eta = 100 "Wirkungsgrad in %";
        constant Real g_n = Modelica.Constants.g_n;
        parameter Modelica.SIunits.Mass m = 1;
        parameter Modelica.SIunits.Length s_max = 10;
        Modelica.SIunits.Length h "Hubhöhe der Masse";
        Modelica.SIunits.Force Fg "Gewichtskraft der angehängten Masse";
        Modelica.SIunits.Velocity v_Masse "Hubgeschwindigkeit der Masse";
        Modelica.SIunits.Acceleration a;
        
      equation
        seilConnect1.s_max = s_max;
        seilConnect1.nGes2 = n + 1;
        seilConnect1.Fz * (seilConnect1.nGes + 1 + n) * (eta / 100) = m * g_n;
        Fg = m * g_n;
        h = seilConnect1.s / (seilConnect1.nGes + 1 + n);
        v_Masse = der(h);
        a = der(v_Masse);
        
        v_Masse = seilConnect1.v_Masse;
        h = seilConnect1.h;
        Fg = seilConnect1.Fg;
        
        annotation(
          Icon(graphics = {Ellipse(origin = {-32, 36}, fillColor = {66, 66, 66}, fillPattern = FillPattern.CrossDiag, lineThickness = 0.5, extent = {{-60, 60}, {60, -60}}, endAngle = 360), Ellipse(origin = {-35, 39}, fillColor = {173, 173, 173}, fillPattern = FillPattern.Solid, extent = {{-53, 53}, {59, -59}}, endAngle = 360), Text(origin = {-40, 76}, extent = {{-24, 16}, {34, -36}}, textString = "n = %n"), Rectangle(origin = {-30, -2}, lineColor = {255, 255, 255}, fillPattern = FillPattern.Solid, extent = {{-4, 34}, {4, -34}}), Ellipse(origin = {-31, 31}, fillPattern = FillPattern.Solid, extent = {{-15, 15}, {15, -15}}, endAngle = 360), Text(origin = {-22, -92}, extent = {{-50, 10}, {32, -4}}, textString = "Masse = %m kg"), Line(origin = {34.78, 78}, points = {{-6, -42}, {6, -42}, {6, 36}}, color = {175, 117, 0}, thickness = 0.75), Rectangle(origin = {37, 118}, fillColor = {130, 0, 0}, fillPattern = FillPattern.Solid, extent = {{-49, 10}, {41, -10}}), Ellipse(origin = {-31, -48}, fillColor = {130, 130, 130}, fillPattern = FillPattern.Solid, extent = {{-17, 18}, {19, -18}}, endAngle = 360), Ellipse(origin = {-30, -46}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid, extent = {{-14, 12}, {14, -12}}, endAngle = 360), Polygon(origin = {-30, -62}, fillColor = {130, 130, 130}, fillPattern = FillPattern.Solid, points = {{-24, 18}, {22, 18}, {46, -18}, {-46, -18}, {-24, 18}})}, coordinateSystem(extent = {{-100, -100}, {80, 130}}, initialScale = 0.1)),
          Diagram(coordinateSystem(extent = {{-100, -100}, {80, 130}})),
          __OpenModelica_commandLineOptions = "");
      end Invertierter_Anschluss;

      model Rolle
        Flaschenzug_Gruppe6.Connectoren.SeilConnect seilConnect1 annotation(
          Placement(visible = true, transformation(origin = {-70, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-58, -24}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        Flaschenzug_Gruppe6.Connectoren.SeilConnect seilConnect2 annotation(
          Placement(visible = true, transformation(origin = {-60, 10}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {58, -24}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        parameter Integer n = 1 "Anzahl der Rollen";
        parameter Real eta = 100 "Wirkungsgrad in %";
        Real Wirk = if abs(seilConnect1.nGes) > abs(seilConnect2.nGes) then (eta / 100) ^ n else 1 / (eta / 100) ^ n;
        
      
        
      equation
        seilConnect1.Fz = Wirk * seilConnect2.Fz;
        seilConnect1.s = seilConnect2.s;
        seilConnect1.s_max = seilConnect2.s_max;
        seilConnect1.nGes + seilConnect2.nGes = n;
        seilConnect1.nGes2 + seilConnect2.nGes2 = n;
        
        seilConnect1.h = seilConnect2.h;
        seilConnect1.Fg = seilConnect2.Fg;
        seilConnect1.v_Masse = seilConnect2.v_Masse;
        annotation(
          Icon(graphics = {Ellipse(origin = {0, -26}, fillColor = {66, 66, 66}, fillPattern = FillPattern.CrossDiag, lineThickness = 0.5, extent = {{-60, 60}, {60, -60}}, endAngle = 360), Ellipse(origin = {-3, -23}, fillColor = {173, 173, 173}, fillPattern = FillPattern.Solid, extent = {{-53, 53}, {59, -59}}, endAngle = 360), Text(origin = {-6, -46}, extent = {{-24, 16}, {34, -36}}, textString = "n = %n"), Rectangle(origin = {0, 78}, fillColor = {130, 0, 0}, fillPattern = FillPattern.Solid, extent = {{-80, 10}, {80, -10}}), Rectangle(origin = {0, 20}, lineColor = {255, 255, 255}, fillPattern = FillPattern.Solid, extent = {{-6, 48}, {6, -48}}), Ellipse(origin = {0, -26}, fillPattern = FillPattern.Solid, extent = {{-16, 16}, {16, -16}}, endAngle = 360)}, coordinateSystem(extent = {{-85, -90}, {85, 90}})),
          Diagram(coordinateSystem(extent = {{-85, -90}, {85, 90}})),
          __OpenModelica_commandLineOptions = "");
      end Rolle;
    equation

      annotation(
        Icon(graphics = {Rectangle(lineColor = {200, 200, 200}, fillColor = {248, 248, 248}, fillPattern = FillPattern.HorizontalCylinder, extent = {{-100, -100}, {100, 100}}, radius = 25), Ellipse(origin = {0, 15}, fillColor = {95, 95, 95}, fillPattern = FillPattern.CrossDiag, extent = {{-80, 80}, {80, -80}}, endAngle = 360), Ellipse(origin = {0, 15}, fillColor = {200, 200, 200}, fillPattern = FillPattern.Solid, extent = {{-70, 70}, {70, -70}}, endAngle = 360), Rectangle(lineColor = {95, 95, 95}, fillPattern = FillPattern.Solid, extent = {{-6, 15}, {6, -95}}), Ellipse(origin = {0, 15}, fillPattern = FillPattern.Solid, extent = {{-20, 20}, {20, -20}}, endAngle = 360)}),
        Diagram,
        __OpenModelica_commandLineOptions = "");
    end Anschlussarten;
  equation

  annotation(
      Icon(graphics = {Rectangle(lineColor = {200, 200, 200}, fillColor = {248, 248, 248}, fillPattern = FillPattern.HorizontalCylinder, extent = {{-100, -100}, {100, 100}}, radius = 25), Polygon(origin = {62, -66}, fillColor = {95, 95, 95}, fillPattern = FillPattern.CrossDiag, points = {{-30, -20}, {30, -20}, {30, 8}, {16, 20}, {-16, 20}, {-30, 8}, {-30, -20}}), Rectangle(origin = {36, 82}, fillColor = {130, 0, 0}, fillPattern = FillPattern.Solid, extent = {{-50, 6}, {50, -6}}), Ellipse(origin = {32, 24}, fillColor = {95, 95, 95}, fillPattern = FillPattern.CrossDiag, extent = {{-30, 30}, {30, -30}}, endAngle = 360), Ellipse(origin = {32, 24}, fillColor = {200, 200, 200}, fillPattern = FillPattern.Solid, extent = {{-26, 26}, {26, -26}}, endAngle = 360), Ellipse(origin = {32, 24}, fillPattern = FillPattern.Solid, extent = {{-8, 8}, {8, -8}}, endAngle = 360), Rectangle(origin = {32, 50}, fillPattern = FillPattern.Solid, extent = {{-3, 26}, {3, -26}}), Rectangle(origin = {-59, -47}, fillPattern = FillPattern.Solid, extent = {{-33, 3}, {29, -3}}), Rectangle(origin = {-25, -19}, fillPattern = FillPattern.Solid, extent = {{-5, 7}, {5, -7}}), Rectangle(origin = {-77, -40}, fillColor = {200, 200, 200}, fillPattern = FillPattern.Solid, extent = {{-5, 4}, {5, -4}}), Rectangle(origin = {-45, -40}, fillColor = {200, 200, 200}, fillPattern = FillPattern.Solid, extent = {{-5, 4}, {5, -4}}), Rectangle(origin = {-60, -18}, fillColor = {200, 200, 200}, fillPattern = FillPattern.Horizontal, extent = {{-34, -18}, {30, 18}}), Line(origin = {62.1046, -10}, points = {{0, 36}, {0, -36}}, color = {175, 117, 0}, thickness = 0.6), Line(origin = {-8.7, 6.03}, points = {{12, 27}, {-11, -25}}, color = {175, 117, 0}, thickness = 0.6)}, coordinateSystem(initialScale = 0.1)),
      uses(Modelica(version = "3.2.3")),
      Diagram,
      version = "",
      __OpenModelica_commandLineOptions = "");
  end Flaschenzug_Komponenten;

  package Modelle
    model Test_Rolle
    Flaschenzug_Gruppe6.Flaschenzug_Komponenten.Masse masse1 annotation(
        Placement(visible = true, transformation(origin = {65, -63}, extent = {{-25, -25}, {25, 25}}, rotation = 0)));
    Flaschenzug_Gruppe6.Flaschenzug_Komponenten.Antrieb.Antrieb antrieb1 annotation(
        Placement(visible = true, transformation(origin = {-45.558, -18.0688}, extent = {{-55.442, -23.7609}, {55.442, 22.9688}}, rotation = 0)));
    Flaschenzug_Gruppe6.Flaschenzug_Komponenten.Scope scope1 annotation(
        Placement(visible = true, transformation(origin = {-65, 54.5738}, extent = {{-23.1, -30.6738}, {23.1, 30.6738}}, rotation = 0)));
    Flaschenzug_Gruppe6.Flaschenzug_Komponenten.Anschlussarten.Rolle rolle1(n = 2)  annotation(
        Placement(visible = true, transformation(origin = {42.5556, 51.8824}, extent = {{-31.0556, -32.8824}, {31.0556, 32.8824}}, rotation = 0)));
    equation
      connect(masse1.seilConnect1, rolle1.seilConnect2) annotation(
        Line(points = {{65, -41.5}, {64, -41.5}, {64, 44}}));
      connect(scope1.scopePort1, antrieb1.scopePort1) annotation(
        Line(points = {{-82, 30}, {-82, -2}, {-78, -2}}));
      connect(rolle1.seilConnect1, antrieb1.seilConnect1) annotation(
        Line(points = {{22, 44}, {0, 44}, {0, -34}, {-2, -34}}));
      annotation(
        Icon(graphics = {Ellipse(lineColor = {75, 138, 73}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid, extent = {{-100, -100}, {100, 100}}, endAngle = 360), Polygon(fillColor = {75, 138, 73}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, points = {{-36, 60}, {64, 0}, {-36, -60}, {-36, 60}})}),
        Diagram,
        __OpenModelica_commandLineOptions = "");
    end Test_Rolle;

    model Test_Rolle_2
  Flaschenzug_Gruppe6.Flaschenzug_Komponenten.Antrieb.Antrieb antrieb1 annotation(
        Placement(visible = true, transformation(origin = {-17.1237, 22.0899}, extent = {{-53.8763, -23.0899}, {53.8763, 22.3202}}, rotation = 0)));
  Flaschenzug_Gruppe6.Flaschenzug_Komponenten.Scope scope1 annotation(
        Placement(visible = true, transformation(origin = {-35.2469, 73.7213}, extent = {{-16.8531, -22.3787}, {16.8531, 22.3787}}, rotation = 0)));
  Flaschenzug_Gruppe6.Flaschenzug_Komponenten.Anschlussarten.Invertierter_Anschluss invertierter_Anschluss1 annotation(
        Placement(visible = true, transformation(origin = {68.4148, -53.0726}, extent = {{-41.0198, -41.0198}, {32.8159, 53.3258}}, rotation = 0)));
    equation
  connect(antrieb1.scopePort1, scope1.scopePort1) annotation(
        Line(points = {{-48, 39}, {-47, 39}, {-47, 55}}));
  connect(antrieb1.seilConnect1, invertierter_Anschluss1.seilConnect1) annotation(
        Line(points = {{27, 6}, {27, -12}, {28, -12}, {28, -32}}));
      annotation(
        Icon(graphics = {Ellipse(lineColor = {75, 138, 73}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid, extent = {{-100, -100}, {100, 100}}, endAngle = 360), Polygon(fillColor = {75, 138, 73}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, points = {{-36, 60}, {64, 0}, {-36, -60}, {-36, 60}})}),
        Diagram,
        __OpenModelica_commandLineOptions = "");
    end Test_Rolle_2;
    annotation(
      Icon(graphics = {Rectangle(lineColor = {200, 200, 200}, fillColor = {248, 248, 248}, fillPattern = FillPattern.HorizontalCylinder, extent = {{-100, -100}, {100, 100}}, radius = 25), Polygon(fillColor = {75, 138, 73}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, points = {{-36, 60}, {64, 0}, {-36, -60}, {-36, 60}})}),
      Diagram,
      __OpenModelica_commandLineOptions = "");
  end Modelle;
  annotation(
    Icon(graphics = {Rectangle(lineColor = {200, 200, 200}, fillColor = {248, 248, 248}, fillPattern = FillPattern.HorizontalCylinder, extent = {{-100, -100}, {100, 100}}, radius = 25), Polygon(origin = {26, -68}, fillColor = {95, 95, 95}, fillPattern = FillPattern.CrossDiag, points = {{-30, -20}, {30, -20}, {30, 8}, {16, 20}, {-16, 20}, {-30, 8}, {-30, -20}}), Rectangle(origin = {36, 82}, fillColor = {130, 0, 0}, fillPattern = FillPattern.Solid, extent = {{-50, 6}, {50, -6}}), Ellipse(origin = {26, 10}, fillColor = {95, 95, 95}, fillPattern = FillPattern.CrossDiag, extent = {{-30, 30}, {30, -30}}, endAngle = 360), Ellipse(origin = {26, 10}, fillColor = {200, 200, 200}, fillPattern = FillPattern.Solid, extent = {{-26, 26}, {26, -26}}, endAngle = 360), Ellipse(origin = {26, 10}, fillPattern = FillPattern.Solid, extent = {{-8, 8}, {8, -8}}, endAngle = 360), Line(origin = {56, 44}, points = {{0, -32}, {0, 32}}, color = {175, 117, 0}, thickness = 0.6), Rectangle(origin = {26, -22}, fillPattern = FillPattern.Solid, extent = {{-3, 26}, {3, -26}}), Line(origin = {-36.5581, 10.7442}, rotation = 90, points = {{0, -32}, {0, -12}}, color = {175, 117, 0}, thickness = 0.6), Rectangle(origin = {-59, -17}, fillPattern = FillPattern.Solid, extent = {{-33, 3}, {29, -3}}), Rectangle(origin = {-25, 11}, fillPattern = FillPattern.Solid, extent = {{-5, 7}, {5, -7}}), Rectangle(origin = {-77, -10}, fillColor = {200, 200, 200}, fillPattern = FillPattern.Solid, extent = {{-5, 4}, {5, -4}}), Rectangle(origin = {-45, -10}, fillColor = {200, 200, 200}, fillPattern = FillPattern.Solid, extent = {{-5, 4}, {5, -4}}), Rectangle(origin = {-60, 12}, fillColor = {200, 200, 200}, fillPattern = FillPattern.Horizontal, extent = {{-34, -18}, {30, 18}})}),
    uses(Modelica(version = "3.2.3")),
    Diagram,
    version = "",
    __OpenModelica_commandLineOptions = "");
end Flaschenzug_Gruppe6;
