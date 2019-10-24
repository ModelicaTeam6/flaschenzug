package Flaschenzug_Gr6
  package Connectoren
    connector SeilConnect
      Real Fz;
      // Seilkraft
      Real s;
      //Seilweg
      Real nGes;
      //Gesamtzahl der Rollen
      annotation(
        Icon(graphics = {Ellipse(fillColor = {0, 85, 255}, fillPattern = FillPattern.Solid, extent = {{-98, 98}, {98, -98}}, endAngle = 360)}));
    end SeilConnect;

    connector StromPort
    Real I "Strom";
    
      annotation(
        Icon(graphics = {Rectangle(fillColor = {255, 0, 0}, fillPattern = FillPattern.Solid, extent = {{-60, 60}, {60, -60}}), Text(origin = {1, -2}, extent = {{-39, 24}, {39, -24}}, textString = "I_Port")}));
    end StromPort;

    connector SeilPort
    Real w "Drehzahl";
    
      annotation(
        Icon(graphics = {Rectangle(origin = {-10, 0}, fillColor = {255, 170, 0}, fillPattern = FillPattern.Solid, extent = {{-70, 60}, {70, -60}}), Text(origin = {-10, 0}, extent = {{-40, 22}, {40, -22}}, textString = "Seil Port")}));
    end SeilPort;
  end Connectoren;

  model Rolle
    Flaschenzug_Gr6.Connectoren.SeilConnect seilConnect1 annotation(
      Placement(visible = true, transformation(origin = {-70, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-58, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Flaschenzug_Gr6.Connectoren.SeilConnect seilConnect2 annotation(
      Placement(visible = true, transformation(origin = {-60, 10}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {58, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    parameter Integer n = 1 "Anzahl der Rollen";
  equation
    seilConnect1.Fz = seilConnect2.Fz;
    seilConnect1.s = seilConnect2.s;
    seilConnect1.nGes + abs(n) = seilConnect2.nGes;
    annotation(
      Icon(graphics = {Ellipse(fillColor = {200, 200, 200}, fillPattern = FillPattern.Solid, extent = {{-60, 60}, {60, -60}}, endAngle = 360), Ellipse(fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid, extent = {{-20, 20}, {20, -20}}, endAngle = 360), Text(origin = {-3, -42}, extent = {{-19, 8}, {19, -8}}, textString = "n=%n")}, coordinateSystem(initialScale = 0.1)));
  end Rolle;

  model Masse
    Flaschenzug_Gr6.Connectoren.SeilConnect seilConnect1 annotation(
      Placement(visible = true, transformation(origin = {0, 70}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {0, 68}, extent = {{-6, -6}, {6, 6}}, rotation = 0)));
    constant Real g_n = 9.80665;
    parameter Real m = 1;
    Real n = if seilConnect1.nGes < 1 then 1 else seilConnect1.nGes;
    //Null Rollen entspricht dem Zustand mit einer Rolle
    Real h;
    // Hubhöhe
    Real v;
    //Hubgeschwindigkeit
    Real a;
    //Hubbeschleunigung
  equation
    seilConnect1.Fz * n = m * g_n+m*a;
//Gewichtskraft Fg = m*g = n*Fz
    h = seilConnect1.s / n;
    der(h) = v;
    der(v) = a;
    annotation(
      Icon(graphics = {Ellipse(origin = {0, 40}, fillColor = {130, 130, 130}, fillPattern = FillPattern.Solid, extent = {{-30, 30}, {30, -30}}, endAngle = 360), Ellipse(origin = {0, 40}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid, extent = {{-20, 20}, {20, -20}}, endAngle = 360), Polygon(origin = {0, 10}, fillColor = {130, 130, 130}, fillPattern = FillPattern.Solid, points = {{-40, 30}, {40, 30}, {60, -30}, {-60, -30}, {-60, -30}, {-40, 30}})}));
  end Masse;

  model PlHa_Motor
    Flaschenzug_Gr6.Connectoren.SeilConnect seilConnect1 annotation(
      Placement(visible = true, transformation(origin = {-70, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {80, -50}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    parameter Real I = 1 "Erregerstrom";
    parameter Real ke = 1.24 "Drehmomentkonstante";
    parameter Real P = 3200 "Leistung";
    parameter Real r = 0.1 "Radius";
    Real v;
    Real Fz;
  equation
    seilConnect1.nGes = 0;
    Fz + seilConnect1.Fz = 0;
    v = P * r / (ke * I);
    der(seilConnect1.s) = v;
    annotation(
      Icon(graphics = {Rectangle(origin = {10, -10}, fillPattern = FillPattern.Solid, extent = {{-90, 90}, {70, -70}}), Text(origin = {-28, 0}, lineColor = {255, 255, 255}, extent = {{-52, 40}, {108, 0}}, textString = "Platzhalter"), Text(origin = {-28, -34}, lineColor = {255, 255, 255}, extent = {{-52, 40}, {108, 0}}, textString = "fuer Motor")}, coordinateSystem(initialScale = 0.1)));
  end PlHa_Motor;

  package Antrieb
    model Motor
     
  Connectoren.StromPort stromPort1 annotation(
        Placement(visible = true, transformation(origin = {-60, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-60, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Connectoren.SeilPort seilPort1 annotation(
        Placement(visible = true, transformation(origin = {60, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {60, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    
    
    parameter Real ke = 1.24 "Drehmomentkonstante";
    parameter Real P = 3200 "Leistung";
    
    Real w;
    
    equation
      //seilConnect1.nGes = 0;
      //Fz + seilConnect1.Fz = 0;
      w = P/ (ke * stromPort1.I);
      seilPort1.w = w;
      annotation(
        Icon(graphics = {Ellipse(fillColor = {85, 0, 255}, fillPattern = FillPattern.Solid, extent = {{-60, 58}, {60, -58}}, endAngle = 360), Text(origin = {2, 1}, extent = {{-32, 23}, {32, -23}}, textString = "Motor")}));
    end Motor;

    model Seiltrommel
    Connectoren.SeilPort seilPort1 annotation(
        Placement(visible = true, transformation(origin = {0, 58}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {0, 58}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Connectoren.SeilConnect seilConnect1 annotation(
        Placement(visible = true, transformation(origin = {-60, -20}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-60, -20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    
    parameter Real r = 0.1 "Radius";
    
    Real Fz;
    Real v;
    
    equation
seilConnect1.nGes = 0;
    Fz + seilConnect1.Fz = 0;
    v = seilPort1.w*r;
    der(seilConnect1.s) = v;
    
    annotation(
        Icon(graphics = {Rectangle(origin = {0, 44}, fillColor = {201, 201, 201}, fillPattern = FillPattern.Solid, extent = {{-60, 4}, {60, -4}}), Rectangle(origin = {0, -36}, fillColor = {201, 201, 201}, fillPattern = FillPattern.Solid, extent = {{-60, 4}, {60, -4}}), Rectangle(origin = {0, 4}, fillColor = {201, 201, 201}, fillPattern = FillPattern.Solid, extent = {{-40, 36}, {40, -36}}), Line(origin = {-22.4541, 10.1063}, points = {{-17.5459, 29.8937}, {62.4541, 9.89366}, {-17.5459, 9.89366}, {62.4541, -10.1063}, {-17.5459, -10.1063}, {62.4541, -30.1063}, {-37.5459, -30.1063}}), Rectangle(origin = {0, 53}, extent = {{-4, 5}, {4, -5}})}));end Seiltrommel;

    model Stromquelle
    Connectoren.StromPort stromPort1 annotation(
        Placement(visible = true, transformation(origin = {40, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {40, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    
    parameter Real I = 1 "Erregerstrom";
    
    equation
    stromPort1.I = I;

    annotation(
        Icon(graphics = {Ellipse(fillColor = {201, 201, 201}, fillPattern = FillPattern.Solid,extent = {{-40, 40}, {40, -40}}, endAngle = 360), Ellipse(origin = {-19, 1}, fillPattern = FillPattern.Solid, extent = {{-11, 11}, {11, -11}}, endAngle = 360), Ellipse(origin = {19, 1}, fillPattern = FillPattern.Solid, extent = {{-11, 11}, {11, -11}}, endAngle = 360)}));end Stromquelle;

    model Antrieb
    Flaschenzug_Gr6.Antrieb.Motor motor1 annotation(
        Placement(visible = true, transformation(origin = {8, 2}, extent = {{-28, -28}, {28, 28}}, rotation = 0)));
  Flaschenzug_Gr6.Antrieb.Seiltrommel seiltrommel1 annotation(
        Placement(visible = true, transformation(origin = {53, 19}, extent = {{-29, -29}, {29, 29}}, rotation = 180)));
  Flaschenzug_Gr6.Antrieb.Stromquelle stromquelle1 annotation(
        Placement(visible = true, transformation(origin = {-40, 2}, extent = {{-18, -18}, {18, 18}}, rotation = 0)));
    equation
      connect(motor1.seilPort1, seiltrommel1.seilPort1) annotation(
        Line(points = {{24, 2}, {52, 2}, {52, 2}, {52, 2}}));
      connect(stromquelle1.stromPort1, motor1.stromPort1) annotation(
        Line(points = {{-32, 2}, {-8, 2}, {-8, 2}, {-8, 2}}));
    annotation(
        Icon(graphics = {Rectangle(origin = {-19, -16}, fillColor = {201, 201, 201}, fillPattern = FillPattern.Solid, extent = {{-55, 50}, {55, -50}}), Text(origin = {-18, -12}, extent = {{-40, 24}, {40, -24}}, textString = "Antrieb")}));end Antrieb;
  end Antrieb;

  package Modelle
    model Null_Rollen
      Flaschenzug_Gr6.PlHa_Motor plHa_Motor1 annotation(
        Placement(visible = true, transformation(origin = {-28, 56}, extent = {{-36, -36}, {36, 36}}, rotation = 0)));
      Flaschenzug_Gr6.Masse masse1 annotation(
        Placement(visible = true, transformation(origin = {5, -51}, extent = {{-45, -45}, {45, 45}}, rotation = 0)));
    equation
      connect(plHa_Motor1.seilConnect1, masse1.seilConnect1) annotation(
        Line(points = {{0, 38}, {4, 38}, {4, -20}, {6, -20}}));
    end Null_Rollen;

    model Eine_Rolle
      Flaschenzug_Gr6.PlHa_Motor plHa_Motor1(s = 1) annotation(
        Placement(visible = true, transformation(origin = {-64, -18}, extent = {{-28, -28}, {28, 28}}, rotation = 0)));
      Flaschenzug_Gr6.Rolle rolle1(n = 1) annotation(
        Placement(visible = true, transformation(origin = {-11, 59}, extent = {{-23, -23}, {23, 23}}, rotation = 0)));
      Flaschenzug_Gr6.Masse masse1(m = 1) annotation(
        Placement(visible = true, transformation(origin = {2, -12}, extent = {{-30, -30}, {30, 30}}, rotation = 0)));
    equation
      connect(rolle1.seilConnect2, masse1.seilConnect1) annotation(
        Line(points = {{2, 60}, {2, 8}}));
      connect(plHa_Motor1.seilConnect1, rolle1.seilConnect1) annotation(
        Line(points = {{-42, -32}, {-24, -32}, {-24, 60}, {-24, 60}}));
    end Eine_Rolle;

    model Zwei_Rollen
      Flaschenzug_Gr6.PlHa_Motor plHa_Motor1(I = -1) annotation(
        Placement(visible = true, transformation(origin = {-64, -18}, extent = {{-28, -28}, {28, 28}}, rotation = 0)));
      Flaschenzug_Gr6.Rolle rolle1(n = 1) annotation(
        Placement(visible = true, transformation(origin = {-11, 59}, extent = {{-23, -23}, {23, 23}}, rotation = 0)));
      Flaschenzug_Gr6.Masse masse1(m = 1) annotation(
        Placement(visible = true, transformation(origin = {44, -30}, extent = {{-30, -30}, {30, 30}}, rotation = 0)));
      Flaschenzug_Gr6.Rolle rolle2 annotation(
        Placement(visible = true, transformation(origin = {29, 59}, extent = {{-23, -23}, {23, 23}}, rotation = 0)));
    equation
      connect(rolle2.seilConnect2, masse1.seilConnect1) annotation(
        Line(points = {{42, 60}, {44, 60}, {44, -10}}));
      connect(rolle1.seilConnect2, rolle2.seilConnect1) annotation(
        Line(points = {{2, 60}, {16, 60}, {16, 60}, {16, 60}}));
      connect(plHa_Motor1.seilConnect1, rolle1.seilConnect1) annotation(
        Line(points = {{-42, -32}, {-24, -32}, {-24, 60}, {-24, 60}}));
    end Zwei_Rollen;

    model Falschenzug_Test
  Flaschenzug_Gr6.Rolle rolle1(n = 3)  annotation(
        Placement(visible = true, transformation(origin = {-8.88178e-16, 44}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  Flaschenzug_Gr6.Masse masse1 annotation(
        Placement(visible = true, transformation(origin = {0, -38}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Antrieb.Motor motor1 annotation(
        Placement(visible = true, transformation(origin = {-58, 42}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Flaschenzug_Gr6.Antrieb.Seiltrommel seiltrommel1 annotation(
        Placement(visible = true, transformation(origin = {-36, 50}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
  Antrieb.Stromquelle stromquelle1 annotation(
        Placement(visible = true, transformation(origin = {-76, 42}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Rolle rolle2 annotation(
        Placement(visible = true, transformation(origin = {0, 2}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    equation
      connect(rolle2.seilConnect1, masse1.seilConnect1) annotation(
        Line(points = {{-6, 2}, {0, 2}, {0, -32}, {0, -32}}));
      connect(rolle1.seilConnect2, rolle2.seilConnect2) annotation(
        Line(points = {{12, 44}, {6, 44}, {6, 2}, {6, 2}}));
      connect(seiltrommel1.seilConnect1, rolle1.seilConnect1) annotation(
        Line(points = {{-30, 52}, {-12, 52}, {-12, 44}, {-12, 44}}));
      connect(motor1.seilPort1, seiltrommel1.seilPort1) annotation(
        Line(points = {{-52, 42}, {-36, 42}, {-36, 44}, {-36, 44}}));
      connect(stromquelle1.stromPort1, motor1.stromPort1) annotation(
        Line(points = {{-72, 42}, {-64, 42}, {-64, 42}, {-64, 42}}));
    end Falschenzug_Test;
  end Modelle;
end Flaschenzug_Gr6;
