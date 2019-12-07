package Flaschenzug_Gr6
  package Connectoren
    connector SeilConnect
      flow Modelica.SIunits.Force Fz "Seilkraft";
      Modelica.SIunits.Length s "Seilweg";
      Modelica.SIunits.Length s_max "maximaler Seilweg";
      flow Real nGes "Gesamtzahl der Rollen";
      flow Real nGes2 "Gesamtzahl der Rollen";
      annotation(
        Icon(graphics = {Ellipse(fillColor = {175, 117, 0}, fillPattern = FillPattern.CrossDiag, lineThickness = 0.5, extent = {{-98, 98}, {98, -98}}, endAngle = 360)}, coordinateSystem(initialScale = 0.1)));
    end SeilConnect;

    connector Spannungsport
      Modelica.SIunits.Voltage U "Versorgungsspannung";
      annotation(
        Icon(graphics = {Rectangle(fillColor = {255, 0, 0}, fillPattern = FillPattern.CrossDiag, extent = {{-100, 100}, {100, -100}})}, coordinateSystem(initialScale = 0.1)));
    end Spannungsport;

    connector SeilPort
      flow Modelica.SIunits.Torque M_L "Lastmoment";
      Modelica.SIunits.AngularVelocity w "Drehzahl";
      Modelica.SIunits.Length r "Radius";
      Modelica.SIunits.Voltage U "Spannung";
      Modelica.SIunits.Torque M_E "Elektrisches Moment";
      Real d "Drehrichtung";
      annotation(
        Icon(coordinateSystem(initialScale = 0.1), graphics = {Ellipse(fillColor = {255, 255, 127}, fillPattern = FillPattern.CrossDiag,extent = {{-98, 98}, {98, -98}}, endAngle = 360)}));
    end SeilPort;
  annotation(
      Icon(graphics = {Polygon(fillColor = {255, 255, 127},fillPattern = FillPattern.HorizontalCylinder, points = {{-80, 60}, {-80, -60}, {20, -60}, {80, 0}, {20, 60}, {-80, 60}})}));
  end Connectoren;

  model Rolle
    Flaschenzug_Gr6.Connectoren.SeilConnect seilConnect1 annotation(
      Placement(visible = true, transformation(origin = {-70, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-58, -24}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Flaschenzug_Gr6.Connectoren.SeilConnect seilConnect2 annotation(
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
    annotation(
      Icon(graphics = {Ellipse(origin = {0, -24}, fillColor = {66, 66, 66}, fillPattern = FillPattern.CrossDiag, lineThickness = 0.5, extent = {{-60, 60}, {60, -60}}, endAngle = 360), Ellipse(origin = {-3, -21}, fillColor = {173, 173, 173}, fillPattern = FillPattern.Solid, extent = {{-53, 53}, {59, -59}}, endAngle = 360), Text(origin = {-6, -44}, extent = {{-24, 16}, {34, -36}}, textString = "n = %n"), Rectangle(origin = {0, 80}, fillColor = {130, 0, 0}, fillPattern = FillPattern.Solid, extent = {{-80, 10}, {80, -10}}), Rectangle(origin = {0, 22}, lineColor = {255, 255, 255}, fillPattern = FillPattern.Solid, extent = {{-6, 48}, {6, -48}}), Ellipse(origin = {0, -24}, fillPattern = FillPattern.Solid, extent = {{-16, 16}, {16, -16}}, endAngle = 360)}, coordinateSystem(initialScale = 0.1)));
  end Rolle;

  model Rolle_3
    Flaschenzug_Gr6.Connectoren.SeilConnect seilConnect1 annotation(
      Placement(visible = true, transformation(origin = {-70, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-58, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Flaschenzug_Gr6.Connectoren.SeilConnect seilConnect2 annotation(
      Placement(visible = true, transformation(origin = {-60, 10}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {58, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    parameter Integer n = 2 "Anzahl der Rollen";
    parameter Real eta = 100 "Wirkungsgrad in %";
    Real Wirk = if abs(seilConnect1.nGes) > abs(seilConnect2.nGes) then (eta / 100) ^ n else 1 / (eta / 100) ^ n;
    Flaschenzug_Gr6.Connectoren.SeilConnect seilConnect3 annotation(
      Placement(visible = true, transformation(origin = {-60, 10}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {2, -76}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  equation
    seilConnect1.Fz = Wirk * seilConnect2.Fz;
    seilConnect1.s = seilConnect2.s;
    seilConnect1.Fz = Wirk * seilConnect3.Fz;
    seilConnect1.s = seilConnect3.s;
    seilConnect1.s_max = seilConnect3.s_max;
    abs(seilConnect1.nGes) + abs(seilConnect2.nGes) + n - 1 = seilConnect3.nGes;
    abs(seilConnect3.nGes2) + abs(seilConnect2.nGes2) + n = seilConnect1.nGes2;
    annotation(
      Icon(graphics = {Ellipse(fillColor = {66, 66, 66}, fillPattern = FillPattern.CrossDiag, lineThickness = 0.5, extent = {{-60, 60}, {60, -60}}, endAngle = 360), Ellipse(origin = {-3, 3}, fillColor = {173, 173, 173}, fillPattern = FillPattern.Solid, extent = {{-53, 53}, {59, -59}}, endAngle = 360), Text(origin = {-8, 40}, extent = {{-24, 16}, {34, -36}}, textString = "n = %n"), Rectangle(origin = {2, -38}, lineColor = {255, 255, 255}, fillPattern = FillPattern.Solid, extent = {{-4, 34}, {4, -34}}), Ellipse(origin = {1, -5}, fillPattern = FillPattern.Solid, extent = {{-15, 15}, {15, -15}}, endAngle = 360)}, coordinateSystem(initialScale = 0.1)));
  end Rolle_3;

  model Masse
    Flaschenzug_Gr6.Connectoren.SeilConnect seilConnect1 annotation(
      Placement(visible = true, transformation(origin = {0, 70}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {5.55112e-15, 86}, extent = {{-14, -14}, {14, 14}}, rotation = 0)));
    constant Real g_n = Modelica.Constants.g_n;
    parameter Modelica.SIunits.Mass m = 1;
    parameter Modelica.SIunits.Length s_max = 10;
    Real n = if abs(seilConnect1.nGes) < 1 then 1 else abs(seilConnect1.nGes);
    //Null Rollen entspricht dem Zustand mit einer Rolle
    Modelica.SIunits.Length h;
    // Hubhöhe
    Modelica.SIunits.Force Fg "Gewichtskraft";
    Modelica.SIunits.Velocity v;
    //Hubgeschwindigkeit
    Modelica.SIunits.Acceleration a;
    //Hubbeschleunigung
  equation
    seilConnect1.s_max=s_max;
    seilConnect1.nGes2 = 0;
    seilConnect1.Fz*n = m * g_n;
    Fg = m * g_n;
    h = seilConnect1.s / n;
    der(h) = v;
    der(v) = a;
    annotation(
      Icon(graphics = {Ellipse(origin = {-10, 48}, fillColor = {130, 130, 130}, fillPattern = FillPattern.Solid, lineThickness = 0.5, extent = {{-40, 40}, {60, -60}}, endAngle = 360), Ellipse(origin = {10, 30}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid, lineThickness = 0.5, extent = {{-40, 40}, {20, -22}}, endAngle = 360), Text(origin = {-74, -90}, extent = {{-22, 30}, {172, -10}}, textString = "Masse = %m kg"), Polygon(origin = {0, -10}, fillColor = {130, 130, 130}, fillPattern = FillPattern.Solid, lineThickness = 0.5, points = {{-60, 50}, {60, 50}, {100, -50}, {-100, -50}, {-60, 50}})}, coordinateSystem(initialScale = 0.1)));
  end Masse;

  model Decke
    Flaschenzug_Gr6.Connectoren.SeilConnect seilConnect1 annotation(
      Placement(visible = true, transformation(origin = {2, 60}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {0, 18}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.SIunits.Force F;
    Modelica.SIunits.Length delta_x;
  equation
    seilConnect1.nGes2 = 0;
    seilConnect1.nGes = 1;
    F + seilConnect1.Fz = 0;
    delta_x = 0 * seilConnect1.s;
    seilConnect1.s_max = 0;
    annotation(
      Icon(graphics = {Line(origin = {-90, 70}, points = {{10, -10}, {-10, 10}, {-10, 10}, {-10, 10}}), Line(origin = {-70, 70}, points = {{10, -10}, {-10, 10}}), Line(origin = {-49.8789, 70.1211}, points = {{10, -10}, {-10, 10}}), Line(origin = {-29.8181, 70}, points = {{10, -10}, {-10, 10}}), Line(origin = {-10.2272, 70.0001}, points = {{10, -10}, {-10, 10}}), Line(origin = {10.0658, 70.0049}, points = {{10, -10}, {-10, 10}}), Line(origin = {89.8435, 70.121}, points = {{10, -10}, {-10, 10}}), Line(origin = {69.3183, 70.0001}, points = {{10, -10}, {-10, 10}}), Line(origin = {49.7274, 70}, points = {{10, -10}, {-10, 10}}), Line(origin = {29.8987, 70.121}, points = {{10, -10}, {-10, 10}}), Rectangle(origin = {0, 55}, fillColor = {130, 0, 0}, fillPattern = FillPattern.Solid, extent = {{-100, 5}, {100, -31}})}),
      Diagram,
      __OpenModelica_commandLineOptions = "");
  end Decke;

  package Antrieb

    model Antrieb
    
      Flaschenzug_Gr6.Connectoren.SeilConnect seilConnect1 annotation(
        Placement(visible = true, transformation(origin = {50, -44}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {70, -56}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Flaschenzug_Gr6.Antrieb.Antrieb_Komponenten.Spannungsquelle spannungsquelle1 annotation(
        Placement(visible = true, transformation(origin = {-81, -13}, extent = {{-13, -13}, {13, 13}}, rotation = 0)));
  Flaschenzug_Gr6.Antrieb.Antrieb_Komponenten.Seiltrommel seiltrommel1 annotation(
        Placement(visible = true, transformation(origin = {37, 11}, extent = {{-35, -35}, {35, 35}}, rotation = 90)));
  Flaschenzug_Gr6.Antrieb.Antrieb_Komponenten.Motor motor1 annotation(
        Placement(visible = true, transformation(origin = {-48, 12}, extent = {{-28, -28}, {28, 28}}, rotation = 0)));
    equation
      connect(motor1.spannungsport1, spannungsquelle1.spannungsport1) annotation(
        Line(points = {{-68, 12}, {-72, 12}, {-72, -16}}));
      connect(seiltrommel1.seilPort1, motor1.seilPort1) annotation(
        Line(points = {{10, 10}, {-30, 10}, {-30, 12}, {-28, 12}}));
      connect(seiltrommel1.seilConnect1, seilConnect1) annotation(
        Line(points = {{50, -10}, {50, -44}}));
      annotation(
        Icon(graphics = {Rectangle(origin = {2, -58}, fillPattern = FillPattern.Solid, extent = {{-30, -2}, {30, 2}}), Rectangle(origin = {-16, -51}, fillColor = {131, 131, 131}, fillPattern = FillPattern.Solid, extent = {{-4, 5}, {4, -5}}), Rectangle(origin = {20, -51}, fillColor = {131, 131, 131}, fillPattern = FillPattern.Solid, extent = {{-4, 5}, {4, -5}}), Rectangle(origin = {2, -26}, fillColor = {190, 190, 190}, fillPattern = FillPattern.Horizontal, extent = {{-30, 20}, {30, -20}}), Rectangle(origin = {42, -26}, fillColor = {165, 165, 165}, fillPattern = FillPattern.Solid, extent = {{-2, 20}, {2, -20}}), Rectangle(origin = {78, -26}, fillColor = {165, 165, 165}, fillPattern = FillPattern.Solid, extent = {{-2, 20}, {2, -20}}), Rectangle(origin = {60, -25}, fillColor = {173, 173, 173}, fillPattern = FillPattern.Solid, extent = {{-20, 13}, {20, -13}}), Rectangle(origin = {36, -25}, fillPattern = FillPattern.Solid, extent = {{-4, 3}, {4, -3}}), Line(origin = {56.88, -30.32}, points = {{-12.8751, -7.67949}, {-4.87507, 18.3205}, {-4.87507, -7.67949}, {5.12493, 18.3205}, {5.12493, -7.67949}, {13.1249, 18.3205}, {13.1249, -17.6795}}, thickness = 0.5)}, coordinateSystem(initialScale = 0.1)));
    end Antrieb;

    class Antrieb_Komponenten
      model Motor
        Flaschenzug_Gr6.Connectoren.Spannungsport spannungsport1 annotation(
          Placement(visible = true, transformation(origin = {-60, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = { -59, -25}, extent = {{-9, -9}, {9, 9}}, rotation = 0)));
        Flaschenzug_Gr6.Connectoren.SeilPort seilPort1 annotation(
          Placement(visible = true, transformation(origin = {60, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {76, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        parameter Real Jgm = 0.0000306 "Motorträgheitsmoment";
        parameter Real d = -1 "Drehrichtung";
        //parameter Real ke = 1;
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
        //parameter Real ke = 0.1;
        Modelica.SIunits.ElectricalTorqueConstant ke_rem;
        //Hilfsvariable von ke
        Real delta_ke_sat = ke_rat * (1 - crem) / (1 - exp(-1)) * exp(-csat) / Ia_rat;
        //Hilfsvariable 2 von ke;
        Modelica.SIunits.ElectricalTorqueConstant ke;
        Modelica.SIunits.RotationalDampingConstant kt = ke / (2 * Modelica.Constants.pi);
        Modelica.SIunits.Current I;
        Modelica.SIunits.Voltage Ug;
        Modelica.SIunits.Torque M_eff;
        // Real P; //Leistung
        output Modelica.SIunits.AngularVelocity w;
        Modelica.SIunits.Torque M_E;
        input Modelica.SIunits.Torque M_L;
      
      equation
//Berechnung des Stroms
        ke = if abs(I) <= Ia_sat then ke_rem + ke_rat * (1 - crem) / (1 - exp(-1)) * (1 - exp(-I / Ia_rat)) else ke_rat * (1 - crem) / (1 - exp(-1)) + ke_rem + delta_ke_sat * (I - Ia_rat);
        ke_rem = crem * ke_rat;
        Ug = ke * w * 2 * Modelica.Constants.pi;
        spannungsport1.U = I * (R_a + R_fw) + (L_fw + L_a) * der(I) + Ug + 2 * U_b;
//Berechnung des Moments
        M_E = kt * I;
        M_L = seilPort1.M_L;
        M_E - M_L = (Jgm + M_L * seilPort1.r) * der(w);
        M_eff = M_E - M_L;
//seilPort1.w = if spannungsport1.U == 0 then 0 else d*w;
        seilPort1.w = d * w;
        spannungsport1.U = seilPort1.U;
        M_E = seilPort1.M_E;
        
          seilPort1.d = d;
        annotation(
          Icon(coordinateSystem(initialScale = 0.1), graphics = {Rectangle(origin = {0, -52}, fillPattern = FillPattern.Solid, extent = {{-60, 6}, {60, -6}}), Rectangle(origin = {-30, -38}, fillColor = {131, 131, 131}, fillPattern = FillPattern.Solid, extent = {{-10, 8}, {10, -8}}), Rectangle(origin = {30, -38}, fillColor = {131, 131, 131}, fillPattern = FillPattern.Solid, extent = {{10, 8}, {-10, -8}}), Rectangle(fillColor = {190, 190, 190}, fillPattern = FillPattern.Horizontal, extent = {{-60, 30}, {60, -30}}), Rectangle(origin = {70, 0}, fillPattern = FillPattern.Solid, extent = {{10, 10}, {-10, -10}})}));
      end Motor;

      model Seiltrommel
        Flaschenzug_Gr6.Connectoren.SeilPort seilPort1 annotation(
          Placement(visible = true, transformation(origin = {0, 58}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-1, 79}, extent = {{-19, -19}, {19, 19}}, rotation = 0)));
        Flaschenzug_Gr6.Connectoren.SeilConnect seilConnect1 annotation(
          Placement(visible = true, transformation(origin = {-60, -20}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-58, -38}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        parameter Modelica.SIunits.Length r = 0.1 "Radius";
        input Modelica.SIunits.Force Fz;
        Real s;
        output Modelica.SIunits.Velocity v;
        output Modelica.SIunits.Force F_za;
      equation
        seilConnect1.nGes = 0;
        Fz + seilConnect1.Fz = 0;
        seilPort1.r = r;
        F_za = -seilConnect1.Fz;
        v = seilPort1.w * r;
//s_help = s_max*(1-exp(seilConnect1.s));
        der(s) = v;
        seilConnect1.s = seilPort1.d*(-seilConnect1.s_max) * seilConnect1.nGes2*(1-exp(-abs(s)));
//seilConnect1.s = s_max*(1-exp(seilConnect1.s));
        seilPort1.M_L = if seilPort1.U <= 0 then seilPort1.M_E else -F_za * r;
//v = if seilPort1.U == 0 then 0 else if seilPort1.U <= 0 then -seilPort1.w * r else seilPort1.w;
//M_L * seilPort1.w - F_z * v =0;
        annotation(
          Icon(graphics = {Rectangle(origin = {-48, 44}, fillColor = {201, 201, 201}, fillPattern = FillPattern.Solid, extent = {{-40, 4}, {140, -16}}), Rectangle(origin = {-10, -54}, fillColor = {201, 201, 201}, fillPattern = FillPattern.Solid, extent = {{-80, 4}, {100, -16}}), Rectangle(origin = {-8, -8}, fillColor = {201, 201, 201}, fillPattern = FillPattern.Solid, extent = {{-40, 36}, {58, -42}}), Line(origin = {-29.8524, -7.95902}, points = {{-17.5459, 29.8937}, {80.4541, 9.89366}, {-17.5459, 9.89366}, {80.4541, -10.1063}, {-17.5459, -10.1063}, {80.4541, -30.1063}, {-17.5459, -30.1063}}, thickness = 1), Rectangle(origin = {0, 53}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid, extent = {{-6, 9}, {6, -5}})}, coordinateSystem(initialScale = 0.1)));
      end Seiltrommel;

      model Spannungsquelle
        parameter Modelica.SIunits.Voltage U = 24 "Versorgungsspannung";
        Connectoren.Spannungsport spannungsport1 annotation(
          Placement(visible = true, transformation(origin = {70, -26}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {70, -26}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      equation
        spannungsport1.U = U;
        annotation(
          Icon(graphics = {Rectangle(origin = {0, -30}, fillColor = {220, 220, 220}, fillPattern = FillPattern.Solid, lineThickness = 1, extent = {{-70, 70}, {70, -70}}), Ellipse(origin = {-18, 12}, fillColor = {201, 201, 201}, fillPattern = FillPattern.Solid, lineThickness = 1, extent = {{-40, 20}, {80, -100}}, endAngle = 360), Ellipse(origin = {-25, -29}, fillPattern = FillPattern.Solid, extent = {{-11, 11}, {11, -11}}, endAngle = 360), Ellipse(origin = {25, -29}, fillPattern = FillPattern.Solid, extent = {{-11, 11}, {11, -11}}, endAngle = 360)}, coordinateSystem(initialScale = 0.1)));
      end Spannungsquelle;
  annotation(
        Icon(graphics = {Rectangle(origin = {10, 68}, fillColor = {190, 190, 190}, fillPattern = FillPattern.CrossDiag, extent = {{-20, 12}, {0, -148}}), Rectangle(origin = {68, 10}, rotation = -90, fillColor = {190, 190, 190}, fillPattern = FillPattern.CrossDiag, extent = {{0, 12}, {20, -148}}), Rectangle(origin = {-56, 42}, rotation = 45, fillColor = {190, 190, 190}, fillPattern = FillPattern.CrossDiag, extent = {{0, 12}, {20, -148}}), Rectangle(origin = {42, 56}, rotation = -45, fillColor = {190, 190, 190}, fillPattern = FillPattern.CrossDiag, extent = {{0, 12}, {20, -148}}), Ellipse(fillColor = {190, 190, 190}, fillPattern = FillPattern.CrossDiag,extent = {{-60, 60}, {60, -60}}, endAngle = 360), Ellipse(origin = {1, -1}, fillColor = {253, 253, 253}, fillPattern = FillPattern.Solid, extent = {{-15, 15}, {15, -15}}, endAngle = 360)}));
    end Antrieb_Komponenten;
    annotation(
      Icon(graphics = {Polygon(fillColor = {255, 0, 0},fillPattern = FillPattern.HorizontalCylinder, points = {{-80, 60}, {-80, -60}, {20, -60}, {80, 0}, {20, 60}, {-80, 60}})}));
  end Antrieb;

  package Modelle

    model Test_Rolle
    Flaschenzug_Gr6.Rolle rolle1(n = 2)  annotation(
        Placement(visible = true, transformation(origin = {35, 53}, extent = {{-27, -27}, {27, 27}}, rotation = 0)));
  Flaschenzug_Gr6.Masse masse1 annotation(
        Placement(visible = true, transformation(origin = {51, -51}, extent = {{-23, -23}, {23, 23}}, rotation = 0)));
  Flaschenzug_Gr6.Antrieb.Antrieb antrieb1 annotation(
        Placement(visible = true, transformation(origin = {-78, 44}, extent = {{-56, -56}, {56, 56}}, rotation = 0)));
    equation
      connect(rolle1.seilConnect1, antrieb1.seilConnect1) annotation(
        Line(points = {{20, 46}, {-38, 46}, {-38, 13}, {-39, 13}}));
      connect(rolle1.seilConnect2, masse1.seilConnect1) annotation(
        Line(points = {{51, 47}, {51, -31}}));
    annotation(
        Icon(graphics = {Ellipse(fillColor = {85, 255, 255}, fillPattern = FillPattern.HorizontalCylinder,extent = {{-80, 80}, {80, -80}}, endAngle = 360)}));end Test_Rolle;

    model Test_Rolle_2
      Flaschenzug_Gr6.Antrieb.Antrieb antrieb1 annotation(
        Placement(visible = true, transformation(origin = {-45, 69}, extent = {{-41, -41}, {41, 41}}, rotation = 0)));
      Flaschenzug_Gr6.Masse masse1 annotation(
        Placement(visible = true, transformation(origin = {32, -62}, extent = {{-16, -16}, {16, 16}}, rotation = 0)));
      Flaschenzug_Gr6.Rolle_3 rolle_31(n = 2)  annotation(
        Placement(visible = true, transformation(origin = {30, -8}, extent = {{-28, -28}, {28, 28}}, rotation = 0)));
  Flaschenzug_Gr6.Decke decke1 annotation(
        Placement(visible = true, transformation(origin = {45, 67}, extent = {{-41, -41}, {41, 41}}, rotation = 0)));
    equation
      connect(rolle_31.seilConnect3, masse1.seilConnect1) annotation(
        Line(points = {{31, -29}, {32, -29}, {32, -48}}));
      connect(decke1.seilConnect1, rolle_31.seilConnect2) annotation(
        Line(points = {{46, 74}, {46, -8}}));
      connect(antrieb1.seilConnect1, rolle_31.seilConnect1) annotation(
        Line(points = {{-16, 46}, {14, 46}, {14, -8}}));
      annotation(
        Icon(graphics = {Ellipse(fillColor = {85, 255, 255}, fillPattern = FillPattern.HorizontalCylinder, extent = {{-80, 80}, {80, -80}}, endAngle = 360)}));
    end Test_Rolle_2;
  annotation(
      Icon(graphics = {Polygon(fillColor = {0, 255, 255}, fillPattern = FillPattern.HorizontalCylinder, points = {{-80, 60}, {-80, -60}, {20, -60}, {80, 0}, {20, 60}, {-80, 60}})}));
  end Modelle;
  annotation(
    Icon(graphics = {Rectangle(origin = {39, 57}, fillPattern = FillPattern.Solid, extent = {{-39, 3}, {41, -3}}), Ellipse(origin = {32, 11}, fillColor = {190, 190, 190}, fillPattern = FillPattern.CrossDiag, extent = {{-12, 13}, {28, -25}}, endAngle = 360), Ellipse(origin = {39, 5}, fillPattern = FillPattern.Solid, extent = {{-5, 7}, {9, -7}}, endAngle = 360), Polygon(origin = {40, -65}, fillColor = {190, 190, 190}, fillPattern = FillPattern.CrossDiag, points = {{-20, -15}, {20, -15}, {20, 5}, {6, 15}, {-8, 15}, {-20, 5}, {-20, -15}}), Line(origin = {60, 29}, points = {{0, -25}, {0, 25}}, thickness = 0.5), Line(origin = {39.7964, -39.3937}, points = {{0, -11}, {0, 25}}, thickness = 0.5), Rectangle(origin = {-51, 6}, fillColor = {190, 190, 190}, fillPattern = FillPattern.Horizontal, extent = {{-29, 14}, {29, -14}}), Rectangle(origin = {-19, 4}, fillPattern = FillPattern.Solid, extent = {{-3, 4}, {3, -4}}), Line(origin = {4.87783, 4.38462}, rotation = -90, points = {{0, -25}, {0, 15}}, thickness = 0.5), Rectangle(origin = {-51, -17}, fillPattern = FillPattern.Solid, extent = {{-29, 3}, {29, -3}}), Rectangle(origin = {-69, -11}, fillColor = {190, 190, 190}, fillPattern = FillPattern.Solid, extent = {{-3, 3}, {3, -3}}), Rectangle(origin = {-31, -11}, fillColor = {190, 190, 190}, fillPattern = FillPattern.Solid, extent = {{-3, 3}, {3, -3}})}));
end Flaschenzug_Gr6;
