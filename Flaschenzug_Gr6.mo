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
        Icon(graphics = {Ellipse(fillColor = {0, 85, 255}, fillPattern = FillPattern.Solid,extent = {{-98, 98}, {98, -98}}, endAngle = 360)}));
    end SeilConnect;
  end Connectoren;

  model Rolle
  Flaschenzug_Gr6.Connectoren.SeilConnect seilConnect1 annotation(
      Placement(visible = true, transformation(origin = {-70, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-58, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Flaschenzug_Gr6.Connectoren.SeilConnect seilConnect2 annotation(
      Placement(visible = true, transformation(origin = {-60, 10}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {58, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  parameter Real n = 1 "Anzahl der Rollen";
  equation
    seilConnect1.Fz = seilConnect2.Fz;
    seilConnect1.s = seilConnect2.s;
    seilConnect1.nGes + n = seilConnect2.nGes;
    annotation(
      Icon(graphics = {Ellipse(fillColor = {200, 200, 200}, fillPattern = FillPattern.Solid, extent = {{-60, 60}, {60, -60}}, endAngle = 360), Ellipse(fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid, extent = {{-20, 20}, {20, -20}}, endAngle = 360)}, coordinateSystem(initialScale = 0.1)));
  end Rolle;

  model Masse
      Flaschenzug_Gr6.Connectoren.SeilConnect seilConnect1 annotation(
      Placement(visible = true, transformation(origin = {0, 70}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {0, 68}, extent = {{-6, -6}, {6, 6}}, rotation = 0)));
   
   constant Real g_n=9.80665;
   parameter Real m = 1;
   Real n = if seilConnect1.nGes < 1 then 1 else seilConnect1.nGes;
   Real h;         // Hubhöhe
   Real v;         //Hubgeschwindigkeit
   Real a;    
//Hubbeschleunigung
  equation
     
    seilConnect1.Fz * seilConnect1.nGes = m * g_n; //Gewichtskraft Fg = m*g = n*Fz
    h = seilConnect1.s / n;
    der(h) = v;
    der(v) = a;
    
    annotation(
      Icon(graphics = {Ellipse(origin = {0, 40}, fillColor = {130, 130, 130}, fillPattern = FillPattern.Solid, extent = {{-30, 30}, {30, -30}}, endAngle = 360), Ellipse(origin = {0, 40}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid, extent = {{-20, 20}, {20, -20}}, endAngle = 360), Polygon(origin = {0, 10}, fillColor = {130, 130, 130}, fillPattern = FillPattern.Solid, points = {{-40, 30}, {40, 30}, {60, -30}, {-60, -30}, {-60, -30}, {-40, 30}})}));
  end Masse;

  model PlHa_Motor
  Flaschenzug_Gr6.Connectoren.SeilConnect seilConnect1 annotation(
      Placement(visible = true, transformation(origin = {-70, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {80, -50}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Real Fz;
  parameter Real s = 1;
  equation
  seilConnect1.nGes=0;
  Fz+seilConnect1.Fz=0;
  seilConnect1.s = s;
  

  annotation(
      Icon(graphics = {Rectangle(origin = {10, -10}, fillPattern = FillPattern.Solid, extent = {{-90, 90}, {70, -70}}), Text(origin = {-28, 0}, lineColor = {255, 255, 255}, extent = {{-52, 40}, {108, 0}}, textString = "Platzhalter"), Text(origin = {-28, -34}, lineColor = {255, 255, 255}, extent = {{-52, 40}, {108, 0}}, textString = "fuer Motor")}, coordinateSystem(initialScale = 0.1)));end PlHa_Motor;

  model Eine_Rolle
    Flaschenzug_Gr6.PlHa_Motor plHa_Motor1(s = 1)  annotation(
      Placement(visible = true, transformation(origin = {-64, -18}, extent = {{-28, -28}, {28, 28}}, rotation = 0)));
    Flaschenzug_Gr6.Rolle rolle1(n = 1)  annotation(
      Placement(visible = true, transformation(origin = {-11, 59}, extent = {{-23, -23}, {23, 23}}, rotation = 0)));
    Flaschenzug_Gr6.Masse masse1(m = 1)  annotation(
      Placement(visible = true, transformation(origin = {2, -12}, extent = {{-30, -30}, {30, 30}}, rotation = 0)));
  equation
    connect(rolle1.seilConnect2, masse1.seilConnect1) annotation(
      Line(points = {{2, 60}, {2, 8}}));
    connect(plHa_Motor1.seilConnect1, rolle1.seilConnect1) annotation(
      Line(points = {{-42, -32}, {-24, -32}, {-24, 60}, {-24, 60}}));
  end Eine_Rolle;

  model Zwei_Rollen
    Flaschenzug_Gr6.PlHa_Motor plHa_Motor1(s = 1) annotation(
      Placement(visible = true, transformation(origin = {-64, -18}, extent = {{-28, -28}, {28, 28}}, rotation = 0)));
    Flaschenzug_Gr6.Rolle rolle1(n = 1) annotation(
      Placement(visible = true, transformation(origin = {-11, 59}, extent = {{-23, -23}, {23, 23}}, rotation = 0)));
    Flaschenzug_Gr6.Masse masse1(m = 1) annotation(
      Placement(visible = true, transformation(origin = {44, -24}, extent = {{-30, -30}, {30, 30}}, rotation = 0)));
  Flaschenzug_Gr6.Rolle rolle2 annotation(
      Placement(visible = true, transformation(origin = {29, 59}, extent = {{-23, -23}, {23, 23}}, rotation = 0)));
  equation
    connect(rolle2.seilConnect2, masse1.seilConnect1) annotation(
      Line(points = {{42, 60}, {44, 60}, {44, -4}, {44, -4}}));
    connect(rolle1.seilConnect2, rolle2.seilConnect1) annotation(
      Line(points = {{2, 60}, {16, 60}, {16, 60}, {16, 60}}));
    connect(plHa_Motor1.seilConnect1, rolle1.seilConnect1) annotation(
      Line(points = {{-42, -32}, {-24, -32}, {-24, 60}, {-24, 60}}));
  end Zwei_Rollen;
end Flaschenzug_Gr6;
