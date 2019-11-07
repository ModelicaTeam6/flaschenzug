package Flaschenzug_Gr6
  package Connectoren
    connector SeilConnect
      Real Fz;
      // Seilkraft
      Real s;
      //Seilweg
      flow Real nGes;
      //Gesamtzahl der Rollen
      annotation(
        Icon(graphics = {Ellipse(fillColor = {0, 85, 255}, fillPattern = FillPattern.Solid, lineThickness = 0.5, extent = {{-98, 98}, {98, -98}}, endAngle = 360)}, coordinateSystem(initialScale = 0.1)));
    end SeilConnect;

    connector StromPort
    Real I "Strom";
    
      annotation(
        Icon(graphics = {Rectangle(fillColor = {255, 0, 0}, fillPattern = FillPattern.Solid, extent = {{-100, 100}, {100, -100}}), Text(origin = {-61, 24}, extent = {{-37, 24}, {155, -60}}, textString = "I_Port")}, coordinateSystem(initialScale = 0.1)));
    end StromPort;

    connector SeilPort
    Real M_L "Lastmoment";
    Real w "Drehzahl";
    
      annotation(
        Icon(graphics = {Rectangle(origin = {-30, 40}, fillColor = {255, 170, 0}, fillPattern = FillPattern.Solid, extent = {{-70, 60}, {130, -140}}), Text(origin = {-10, 10}, extent = {{-86, 44}, {106, -60}}, textString = "Seil Port")}, coordinateSystem(initialScale = 0.1)));
    end SeilPort;

    package Beispiele
    end Beispiele;

    model Ohne_Rollen
    Flaschenzug_Gr6.Antrieb.Stromquelle stromquelle1 annotation(
        Placement(visible = true, transformation(origin = {-80, 74}, extent = {{-12, -12}, {12, 12}}, rotation = 0)));
  Flaschenzug_Gr6.Antrieb.Motor motor1 annotation(
        Placement(visible = true, transformation(origin = {-48, 70}, extent = {{-16, -16}, {16, 16}}, rotation = 0)));
  Flaschenzug_Gr6.Antrieb.Seiltrommel seiltrommel1 annotation(
        Placement(visible = true, transformation(origin = {-11, 69}, extent = {{-17, -17}, {17, 17}}, rotation = 90)));
  Flaschenzug_Gr6.Masse masse1 annotation(
        Placement(visible = true, transformation(origin = {53, -17}, extent = {{-17, -17}, {17, 17}}, rotation = 0)));
    equation
    connect(motor1.seilPort1, seiltrommel1.seilPort1) annotation(
        Line(points = {{-37, 70}, {-24, 70}, {-24, 69}}));
    connect(stromquelle1.stromPort1, motor1.stromPort1) annotation(
        Line(points = {{-72, 70}, {-59, 70}}));
    end Ohne_Rollen;
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
    seilConnect1.nGes+seilConnect2.nGes=n;
    annotation(
      Icon(graphics = {Ellipse(fillColor = {200, 200, 200}, fillPattern = FillPattern.Solid, lineThickness = 0.5, extent = {{-60, 60}, {60, -60}}, endAngle = 360), Ellipse(fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid, lineThickness = 0.5, extent = {{-20, 20}, {20, -20}}, endAngle = 360), Text(origin = {-9, -30}, extent = {{-19, 8}, {41, -12}}, textString = "n=%n")}, coordinateSystem(initialScale = 0.1)));
  end Rolle;

  model Masse
    Flaschenzug_Gr6.Connectoren.SeilConnect seilConnect1 annotation(
      Placement(visible = true, transformation(origin = {0, 70}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {5.55112e-15, 86}, extent = {{-14, -14}, {14, 14}}, rotation = 0)));
    constant Real g_n = 9.80665;
    parameter Real m = 20;
    Real n = if abs(seilConnect1.nGes) < 1 then 1 else abs(seilConnect1.nGes);
    //Null Rollen entspricht dem Zustand mit einer Rolle
    Real h;
    // Hubhöhe
    Real v;
    //Hubgeschwindigkeit
    Real a;
    //Hubbeschleunigung
  equation
    seilConnect1.Fz * n = m * g_n;
//Gewichtskraft Fg = m*g = n*Fz
    h = seilConnect1.s / n;
    der(h) = v;
    der(v) = a;
    annotation(
      Icon(graphics = {Ellipse(origin = {-10, 48}, fillColor = {130, 130, 130}, fillPattern = FillPattern.Solid, lineThickness = 0.5, extent = {{-40, 40}, {60, -60}}, endAngle = 360), Ellipse(origin = {10, 30}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid, lineThickness = 0.5, extent = {{-40, 40}, {20, -22}}, endAngle = 360),  Text(origin = {-74, -90}, extent = {{-22, 30}, {172, -10}}, textString = "Masse = %m kg"), Polygon(origin = {0, -10}, fillColor = {130, 130, 130}, fillPattern = FillPattern.Solid, lineThickness = 0.5, points = {{-60, 50}, {60, 50}, {100, -50}, {-100, -50}, {-60, 50}})}, coordinateSystem(initialScale = 0.1)));
  end Masse;

  package Antrieb
  model Motor
      Flaschenzug_Gr6.Connectoren.StromPort stromPort1 annotation(
        Placement(visible = true, transformation(origin = {-60, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-71, 1}, extent = {{-15, -15}, {15, 15}}, rotation = 0)));
      Flaschenzug_Gr6.Connectoren.SeilPort seilPort1 annotation(
        Placement(visible = true, transformation(origin = {60, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {69, 1}, extent = {{-15, -15}, {15, 15}}, rotation = 0)));
      parameter Real ke = 1 "Drehmomentkonstante";
      Real P; //Leistung
      parameter Real U = 100;
      output Real w;
      Real M_E;
      input Real M_L;
    equation
//seilConnect1.nGes = 0;
//Fz + seilConnect1.Fz = 0;
      M_E = ke * stromPort1.I;
      seilPort1.M_L = M_L;   
      w = P / (M_E-M_L);
      seilPort1.w = w;
      P - U*stromPort1.I=0;
     M_E-M_L-P/w=0;
    
      
      
      annotation(
        Icon(graphics = {Ellipse(origin = {-8, 12}, fillColor = {239, 239, 0}, fillPattern = FillPattern.Solid, lineThickness = 0.5, extent = {{-62, 58}, {78, -82}}, endAngle = 360), Text(origin = {0, 11}, extent = {{-40, 11}, {38, -29}}, textString = "Motor"), Text(origin = {-20, 94}, extent = {{-40, 6}, {80, -16}}, textString = "k_e = %ke"), Text(origin = {-20, -82}, extent = {{-40, 6}, {80, -16}}, textString = "P = %P W")}, coordinateSystem(initialScale = 0.1)));
    end Motor;

    model Seiltrommel
      Flaschenzug_Gr6.Connectoren.SeilPort seilPort1 annotation(
        Placement(visible = true, transformation(origin = {0, 58}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-1, 79}, extent = {{-19, -19}, {19, 19}}, rotation = 0)));
      Flaschenzug_Gr6.Connectoren.SeilConnect seilConnect1 annotation(
        Placement(visible = true, transformation(origin = {-60, -20}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-58, -38}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      parameter Real r = 0.1 "Radius";
      input Real Fz;
      output Real v;
      output Real M_L;
    equation
      seilConnect1.nGes = 0;
      Fz + seilConnect1.Fz = 0;
      v = seilPort1.w * r;
      der(seilConnect1.s) = v;
      M_L = Fz*r;
      //M_L * seilPort1.w - F_z * v =0;
      
      annotation(
        Icon(graphics = {Rectangle(origin = {-48, 44}, fillColor = {201, 201, 201}, fillPattern = FillPattern.Solid, extent = {{-40, 4}, {140, -16}}), Rectangle(origin = {-10, -54}, fillColor = {201, 201, 201}, fillPattern = FillPattern.Solid, extent = {{-80, 4}, {100, -16}}), Rectangle(origin = {-8, -8}, fillColor = {201, 201, 201}, fillPattern = FillPattern.Solid, extent = {{-40, 36}, {58, -42}}), Line(origin = {-29.8524, -7.95902}, points = {{-17.5459, 29.8937}, {80.4541, 9.89366}, {-17.5459, 9.89366}, {80.4541, -10.1063}, {-17.5459, -10.1063}, {80.4541, -30.1063}, {-17.5459, -30.1063}}, thickness = 1), Rectangle(origin = {0, 53}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid, extent = {{-6, 9}, {6, -5}})}, coordinateSystem(initialScale = 0.1)));
    end Seiltrommel;

    model Stromquelle
      Flaschenzug_Gr6.Connectoren.StromPort stromPort1 annotation(
        Placement(visible = true, transformation(origin = {40, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {71, -27}, extent = {{-25, -25}, {25, 25}}, rotation = 0)));
      parameter Real I = 10 "Erregerstrom";
    equation
      stromPort1.I = I;
      annotation(
        Icon(graphics = {Text(origin = {-5, 51}, extent = {{-69, 49}, {75, -11}}, textString = "I = %I A"), Rectangle(origin = {0, -30}, fillColor = {220, 220, 220}, fillPattern = FillPattern.Solid, lineThickness = 1, extent = {{-70, 70}, {70, -70}}), Ellipse(origin = {-18, 12}, fillColor = {201, 201, 201}, fillPattern = FillPattern.Solid, lineThickness = 1, extent = {{-40, 20}, {80, -100}}, endAngle = 360), Ellipse(origin = {-25, -29}, fillPattern = FillPattern.Solid, extent = {{-11, 11}, {11, -11}}, endAngle = 360), Ellipse(origin = {25, -29}, fillPattern = FillPattern.Solid, extent = {{-11, 11}, {11, -11}}, endAngle = 360)}, coordinateSystem(initialScale = 0.1)));
    end Stromquelle;

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
        Icon(graphics = {Rectangle(origin = {-19, -16}, fillColor = {201, 201, 201}, fillPattern = FillPattern.Solid, extent = {{-55, 50}, {55, -50}}), Text(origin = {-18, -12}, extent = {{-40, 24}, {40, -24}}, textString = "Antrieb")}));
    end Antrieb;
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
        Placement(visible = true, transformation(origin = {-11, 65}, extent = {{-23, -23}, {23, 23}}, rotation = 0)));
      Flaschenzug_Gr6.Masse masse1(m = 1) annotation(
        Placement(visible = true, transformation(origin = {44, -10}, extent = {{-30, -30}, {30, 30}}, rotation = 0)));
    equation
    connect(rolle1.seilConnect2, masse1.seilConnect1) annotation(
        Line(points = {{2, 65}, {2, 62.5}, {44, 62.5}, {44, 16}}));
    connect(plHa_Motor1.seilConnect1, rolle1.seilConnect1) annotation(
        Line(points = {{-42, -32}, {-24, -32}, {-24, 65}}));
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

    model Flaschenzug_Test
      Flaschenzug_Gr6.Rolle rolle1 annotation(
        Placement(visible = true, transformation(origin = {50, 40}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
      Flaschenzug_Gr6.Masse masse1 annotation(
        Placement(visible = true, transformation(origin = {36, -46}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
      Flaschenzug_Gr6.Antrieb.Motor motor1 annotation(
        Placement(visible = true, transformation(origin = {-38, 64}, extent = {{-28, -28}, {28, 28}}, rotation = 0)));
      Flaschenzug_Gr6.Antrieb.Seiltrommel seiltrommel1 annotation(
        Placement(visible = true, transformation(origin = {8, 48}, extent = {{-22, 22}, {22, -22}}, rotation = 180)));
      Flaschenzug_Gr6.Antrieb.Stromquelle stromquelle1 annotation(
        Placement(visible = true, transformation(origin = {-83, 69}, extent = {{-15, -15}, {15, 15}}, rotation = 0)));
      Flaschenzug_Gr6.Rolle rolle2 annotation(
        Placement(visible = true, transformation(origin = {51, 5}, extent = {{-21, -21}, {21, 21}}, rotation = 0)));
    equation
      connect(rolle2.seilConnect1, masse1.seilConnect1) annotation(
        Line(points = {{39, 5}, {36, 5}, {36, -29}}));
      connect(rolle1.seilConnect2, rolle2.seilConnect2) annotation(
        Line(points = {{62, 40}, {63, 40}, {63, 5}}));
      connect(seiltrommel1.seilConnect1, rolle1.seilConnect1) annotation(
        Line(points = {{21, 40}, {38, 40}}));
      connect(motor1.seilPort1, seiltrommel1.seilPort1) annotation(
        Line(points = {{-19, 64}, {-5.5, 64}, {-5.5, 65}, {8, 65}}));
      connect(stromquelle1.stromPort1, motor1.stromPort1) annotation(
        Line(points = {{-72, 65}, {-58, 65}, {-58, 64}}));
    end Flaschenzug_Test;
  end Modelle;

  package Beispiele
    model Zwei_Rollen_inv
      Flaschenzug_Gr6.Rolle rolle1 annotation(
        Placement(visible = true, transformation(origin = {50, 40}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
      Flaschenzug_Gr6.Masse masse1 annotation(
        Placement(visible = true, transformation(origin = {36, -46}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
      Flaschenzug_Gr6.Antrieb.Motor motor1 annotation(
        Placement(visible = true, transformation(origin = {-38, 64}, extent = {{-28, -28}, {28, 28}}, rotation = 0)));
      Flaschenzug_Gr6.Antrieb.Seiltrommel seiltrommel1 annotation(
        Placement(visible = true, transformation(origin = {8, 48}, extent = {{-22, 22}, {22, -22}}, rotation = 180)));
      Flaschenzug_Gr6.Antrieb.Stromquelle stromquelle1 annotation(
        Placement(visible = true, transformation(origin = {-83, 69}, extent = {{-15, -15}, {15, 15}}, rotation = 0)));
      Flaschenzug_Gr6.Rolle rolle2 annotation(
        Placement(visible = true, transformation(origin = {51, 5}, extent = {{-21, -21}, {21, 21}}, rotation = 0)));
  Flaschenzug_Gr6.Rolle rolle3 annotation(
        Placement(visible = true, transformation(origin = {4, 6}, extent = {{-16, -16}, {16, 16}}, rotation = 0)));
    equation
      connect(rolle3.seilConnect1, masse1.seilConnect1) annotation(
        Line(points = {{-6, 6}, {-12, 6}, {-12, -28}, {36, -28}, {36, -28}}));
      connect(rolle2.seilConnect1, rolle3.seilConnect2) annotation(
        Line(points = {{38, 6}, {12, 6}, {12, 6}, {14, 6}}));
      connect(rolle1.seilConnect2, rolle2.seilConnect2) annotation(
        Line(points = {{62, 40}, {63, 40}, {63, 5}}));
      connect(seiltrommel1.seilConnect1, rolle1.seilConnect1) annotation(
        Line(points = {{21, 40}, {38, 40}}));
      connect(motor1.seilPort1, seiltrommel1.seilPort1) annotation(
        Line(points = {{-19, 64}, {-5.5, 64}, {-5.5, 65}, {8, 65}}));
      connect(stromquelle1.stromPort1, motor1.stromPort1) annotation(
        Line(points = {{-72, 65}, {-58, 65}, {-58, 64}}));
    end Zwei_Rollen_inv;

    model Eine_Rolle
      Flaschenzug_Gr6.Masse masse1 annotation(
        Placement(visible = true, transformation(origin = {20, -22}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
      Flaschenzug_Gr6.Antrieb.Motor motor1 annotation(
        Placement(visible = true, transformation(origin = {-38, 64}, extent = {{-28, -28}, {28, 28}}, rotation = 0)));
      Flaschenzug_Gr6.Antrieb.Stromquelle stromquelle1 annotation(
        Placement(visible = true, transformation(origin = {-83, 69}, extent = {{-15, -15}, {15, 15}}, rotation = 0)));
  Antrieb.Seiltrommel seiltrommel1 annotation(
        Placement(visible = true, transformation(origin = {8, 48}, extent = {{-22, 22}, {22, -22}}, rotation = 180)));
    equation
      connect(seiltrommel1.seilConnect1, masse1.seilConnect1) annotation(
        Line(points = {{20, 40}, {20, 40}, {20, -4}, {20, -4}}));
      connect(motor1.seilPort1, seiltrommel1.seilPort1) annotation(
        Line(points = {{-19, 64}, {-5.5, 64}, {-5.5, 65}, {8, 65}}));
      connect(stromquelle1.stromPort1, motor1.stromPort1) annotation(
        Line(points = {{-72, 65}, {-58, 65}, {-58, 64}}));
    end Eine_Rolle;

    model Eine_Rolle_inv
      Flaschenzug_Gr6.Rolle rolle1 annotation(
        Placement(visible = true, transformation(origin = {50, 40}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
      Flaschenzug_Gr6.Masse masse1 annotation(
        Placement(visible = true, transformation(origin = {62, -32}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
      Flaschenzug_Gr6.Antrieb.Motor motor1 annotation(
        Placement(visible = true, transformation(origin = {-38, 64}, extent = {{-28, -28}, {28, 28}}, rotation = 0)));
      Flaschenzug_Gr6.Antrieb.Seiltrommel seiltrommel1 annotation(
        Placement(visible = true, transformation(origin = {8, 48}, extent = {{-22, 22}, {22, -22}}, rotation = 180)));
      Flaschenzug_Gr6.Antrieb.Stromquelle stromquelle1 annotation(
        Placement(visible = true, transformation(origin = {-83, 69}, extent = {{-15, -15}, {15, 15}}, rotation = 0)));
    equation
      connect(rolle1.seilConnect2, masse1.seilConnect1) annotation(
        Line(points = {{62, 40}, {62, 40}, {62, -14}, {62, -14}}));
      connect(seiltrommel1.seilConnect1, rolle1.seilConnect1) annotation(
        Line(points = {{21, 40}, {38, 40}}));
      connect(motor1.seilPort1, seiltrommel1.seilPort1) annotation(
        Line(points = {{-19, 64}, {-5.5, 64}, {-5.5, 65}, {8, 65}}));
      connect(stromquelle1.stromPort1, motor1.stromPort1) annotation(
        Line(points = {{-72, 65}, {-58, 65}, {-58, 64}}));
    end Eine_Rolle_inv;

    model Keine_Rolle
      Flaschenzug_Gr6.Rolle rolle1(n = 3)  annotation(
        Placement(visible = true, transformation(origin = {50, 40}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
      Flaschenzug_Gr6.Masse masse1 annotation(
        Placement(visible = true, transformation(origin = {62, -32}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
      Flaschenzug_Gr6.Antrieb.Motor motor1 annotation(
        Placement(visible = true, transformation(origin = {-38, 64}, extent = {{-28, -28}, {28, 28}}, rotation = 0)));
      Flaschenzug_Gr6.Antrieb.Seiltrommel seiltrommel1 annotation(
        Placement(visible = true, transformation(origin = {8, 48}, extent = {{-22, 22}, {22, -22}}, rotation = 180)));
      Flaschenzug_Gr6.Antrieb.Stromquelle stromquelle1 annotation(
        Placement(visible = true, transformation(origin = {-83, 69}, extent = {{-15, -15}, {15, 15}}, rotation = 0)));
    equation
      connect(rolle1.seilConnect2, masse1.seilConnect1) annotation(
        Line(points = {{62, 40}, {62, 40}, {62, -14}, {62, -14}}));
      connect(seiltrommel1.seilConnect1, rolle1.seilConnect1) annotation(
        Line(points = {{21, 40}, {38, 40}}));
      connect(motor1.seilPort1, seiltrommel1.seilPort1) annotation(
        Line(points = {{-19, 64}, {-5.5, 64}, {-5.5, 65}, {8, 65}}));
      connect(stromquelle1.stromPort1, motor1.stromPort1) annotation(
        Line(points = {{-72, 65}, {-58, 65}, {-58, 64}}));
    end Keine_Rolle;

    model Zwei_Rollen
      Flaschenzug_Gr6.Masse masse1 annotation(
        Placement(visible = true, transformation(origin = {20, -48}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
      Flaschenzug_Gr6.Antrieb.Motor motor1 annotation(
        Placement(visible = true, transformation(origin = {-16, 66}, extent = {{28, -28}, {-28, 28}}, rotation = 0)));
      Flaschenzug_Gr6.Antrieb.Seiltrommel seiltrommel1 annotation(
        Placement(visible = true, transformation(origin = {-70, 48}, extent = {{-22, 22}, {22, -22}}, rotation = 180)));
      Flaschenzug_Gr6.Antrieb.Stromquelle stromquelle1 annotation(
        Placement(visible = true, transformation(origin = {45, 71}, extent = {{15, -15}, {-15, 15}}, rotation = 0)));
      Flaschenzug_Gr6.Rolle rolle2 annotation(
        Placement(visible = true, transformation(origin = {9, 7}, extent = {{-21, -21}, {21, 21}}, rotation = 0)));
  Rolle rolle1 annotation(
        Placement(visible = true, transformation(origin = {-36, 8}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
    equation
      connect(rolle2.seilConnect2, masse1.seilConnect1) annotation(
        Line(points = {{22, 8}, {20, 8}, {20, -30}, {20, -30}}));
      connect(rolle1.seilConnect2, rolle2.seilConnect1) annotation(
        Line(points = {{-24, 8}, {-4, 8}, {-4, 8}, {-4, 8}}));
      connect(seiltrommel1.seilConnect1, rolle1.seilConnect1) annotation(
        Line(points = {{-58, 40}, {-48, 40}, {-48, 8}, {-48, 8}}));
      connect(stromquelle1.stromPort1, motor1.stromPort1) annotation(
        Line(points = {{34, 66}, {6, 66}, {6, 66}, {4, 66}}));
      connect(motor1.seilPort1, seiltrommel1.seilPort1) annotation(
        Line(points = {{-35, 66}, {-5.5, 66}, {-5.5, 65}, {-70, 65}}));
    end Zwei_Rollen;

    model Drei_Rollen
      Flaschenzug_Gr6.Masse masse1 annotation(
        Placement(visible = true, transformation(origin = {56, -48}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
      Flaschenzug_Gr6.Antrieb.Motor motor1 annotation(
        Placement(visible = true, transformation(origin = {-16, 66}, extent = {{28, -28}, {-28, 28}}, rotation = 0)));
      Flaschenzug_Gr6.Antrieb.Seiltrommel seiltrommel1 annotation(
        Placement(visible = true, transformation(origin = {-70, 48}, extent = {{-22, 22}, {22, -22}}, rotation = 180)));
      Flaschenzug_Gr6.Antrieb.Stromquelle stromquelle1 annotation(
        Placement(visible = true, transformation(origin = {45, 71}, extent = {{15, -15}, {-15, 15}}, rotation = 0)));
      Flaschenzug_Gr6.Rolle rolle2 annotation(
        Placement(visible = true, transformation(origin = {3, 9}, extent = {{-21, -21}, {21, 21}}, rotation = 0)));
      Rolle rolle1 annotation(
        Placement(visible = true, transformation(origin = {-36, 8}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  Flaschenzug_Gr6.Rolle rolle3 annotation(
        Placement(visible = true, transformation(origin = {43, 9}, extent = {{-21, -21}, {21, 21}}, rotation = 0)));
    equation
      connect(rolle3.seilConnect2, masse1.seilConnect1) annotation(
        Line(points = {{56, 10}, {56, 10}, {56, -30}, {56, -30}}));
      connect(rolle2.seilConnect2, rolle3.seilConnect1) annotation(
        Line(points = {{16, 10}, {30, 10}, {30, 10}, {30, 10}}));
      connect(rolle1.seilConnect2, rolle2.seilConnect1) annotation(
        Line(points = {{-24, 8}, {-14, 8}, {-14, 9}, {-9, 9}}));
      connect(seiltrommel1.seilConnect1, rolle1.seilConnect1) annotation(
        Line(points = {{-58, 40}, {-48, 40}, {-48, 8}, {-48, 8}}));
      connect(stromquelle1.stromPort1, motor1.stromPort1) annotation(
        Line(points = {{34, 66}, {6, 66}, {6, 66}, {4, 66}}));
      connect(motor1.seilPort1, seiltrommel1.seilPort1) annotation(
        Line(points = {{-35, 66}, {-5.5, 66}, {-5.5, 65}, {-70, 65}}));
    end Drei_Rollen;
  end Beispiele;
end Flaschenzug_Gr6;
