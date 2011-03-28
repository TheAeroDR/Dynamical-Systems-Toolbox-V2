%% Simulink example with demo 'ab' in DST mode
% This demonstration uses the 'ab' example of AUTO to demonstrate the use
% of Simulink with the Dynamical Systems Toolbox in the DST mode.
%
%% Open simulink model 
% The equations are defined in a Simulink model "ab.mdl".
open_system('ab');
snapnow;

%% Find the equilibrium of the system
% The continuation run has to start from an equilibrium state, or a stable
% limit cycle condition. Most applications will start from an equilibrium 
% condition. This equilibrium is also known as a quasi-steady state, 
% or a trim condition. There are two ways to obtain such an equilibrium:
% 
% # Run the simulation for a sufficient period of time, until the
% derivatives (of the states of interest) are equal to zero. This is the
% easiest option.
% # Use a trim routine to obtain a trim point.
%
clear all

%%
% Choose/guess initial conditions
PAR0=[0,14,2;0,14,2];
ts=[0,100];
U0=[0,0];
UT=[ts',PAR0];

options=simset('InitialState',U0);
[T,X,Y]=sim('ab',ts,options,UT);


%%
% Plot the results out. We can see that the state derivatives are zero.
% This is a trivial example seeing that we could have checked this by hand,
% but the method is applicable for more complex models.
h=plot(T,Y);
set(h,'LineWidth',2);
title('Time history for Simulink Demo: ab');
xlabel('Time (s)');
ylabel('U(1),U(2)');
snapnow;
close(gcf);

%% 
% Adjust equations file to contain correct initial conditions
% We can now use the final states of the simulation as starting conditions
% for the continuation runs. If the derivatives for these states are not 
% zero, the continuation runs will fail. 

%%
% Create an auto object
a{1}=auto;

%%
% Define the function file and intial conditions
a{1}.s.FuncFileName='absimfunc';
a{1}.s.SimulinkModel='ab';
a{1}.s.Par0=PAR0(end,:);
a{1}.s.U0=X(end,:);
a{1}.s.Out0=Y(end,:);

%% 
% Print function file to screen.
type(a{1}.s.FuncFileName);


%% Set the constants and run the stationary solutions
% We can set the constants from the command line, but for ease of use we
% can convert the constants file from the original fortran code with the |convertchc|
% function, and then we can read the constants in from the m-file. 
a{1}.c=cab1(a{1}.c);

%%
% Show format of set commands
type('cab1.m');

%%
% Print constants to screen.
a{1}.c

%% Run an equilibrium solution 
% Compute stationary solutions by using the |runauto| method in the |auto|
% object. The Simulink model will be opened if it is not open, and then
% compiled automatically before the analysis starts.
a{1}=runauto(a{1});

%% Check contents written to objects
% In the Fortran version of AUTO the results are written to the fort.7,
% fort.8 and fort.9 files. This is still an option in the DST mode, but
% it is not the default.
% 
% Print f7 contents to screen.
a{1}.f7

%%
% Print f8 contents to screen.
a{1}.f8

%% Plot stationary solutions
% We have seen from the output to the MATLAB command window that there are 
% two limit points and one Hopf bifurcation. We use the |plautobj| object 
% to plot the results. Note the solid lines are used for stable 
% equilibrium states, and broken lines for unstable equilibrium states.
% The limit points (LP) indicate a qualitative change in the stability, 
% while the Hopf bifurcation (HB) indicates a transition from a steady 
% state to a limit cycle. 
p=plautobj;
set(p,'xLab','Par','yLab','L2-norm','axLim',[0,0.16,0,10]);
ploteq(p,a);
snapnow;

%% Compute periodic solutions
% We want to do the continuation from the Hopf Bifurcation to determine the 
% amplitude  and frequency of the limit cycle as we change the parameter.
%
% Copy the information in the first object to the second one. Set
% constants by cloning constants object. Remember that we are using handle 
% classes and that we do not want them to act like pointers, hence use copy
% method from the autoconstants object.
a{2}=a{1};
a{2}.c=copy(a{2}.c);
a{2}.c=cab2(a{2}.c);

% Run continuation
a{2}=runauto(a{2});

%%
% You can see that the runs are a lot longer than the case where we used a
% Matlab function. This is because you make twice as many function
% evaluations due to a call to get the outputs, and then a call to get the 
% derivatives. The output call needs to be done first otherwise the 
% derivatives might be incorrect. Not sure why this is the case, but we
% have seen instances where this occurs.

%% Plot periodic solutions 
% Add the Maximum values of the Hopf-bifurcation. 
ploteq(p,a);
snapnow;

%% Run simulation with slow ramp input
% A continuation analysis is similar to running a simulation with a very slow
% ramp input. We will thus rerun the simulation and then overlay the
% results on top of the bifurcation diagram. In our previous example we plotted
% the |L2-NORM|. We will now work it out from time history data. The stable
% solution falls close to or on top of the blue branches, and then the 
% oscillations appear in the area of point 4, where the Hopf-bifurcation 
% occurs, indicating the onset of limit cycles. 

%%
% Define ramp input
PAR0=[0,14,2;0.2,14,2];
ts=[0,20000];
U0=[0,0];
UT=[ts',PAR0];

%%
% Run simulation. 
options=simset('InitialState',U0);
[T,X,Y]=sim('ab',ts,options,UT);

%% Overlay simulation onto bifurcation diagram
% Plot the simulation on top of the bifurcation diagram.
PAR=interp1(ts,PAR0(:,1),T);
L2norm=sqrt(Y(:,1).^2+Y(:,2).^2);
plot(PAR,L2norm,'m');
snapnow;
close(gcf)

%% Two-parameter continuation, follow locus of lower limit point (Forward)
% Trace out the locus of the lower limit point while stepping in a 
% *forward* direction. We vary the first and the thrid parameters for the 
% continuation, so restart from label 2 in this first continuation, 
% hence we need to copy the restart file from the first run to the 
% appropriate name. Create new object and set constants
a{3}=a{1};
a{3}.c=copy(a{3}.c);
a{3}.c=cab3(a{3}.c);

% Run continuation
a{3}=runauto(a{3});


%% Two-parameter continuation, follow locus of lower limit point (Backward)
% Trace out the locus of the lower limit point while stepping in a 
% *backward* direction. We vary the first and the thrid parameters for the 
% continuation, so restart from label 2 in this first continuation, 
% hence we need to copy the restart file from the first run to the 
% appropriate name. Create new object and set constants
a{4}=a{1};
a{4}.c=copy(a{4}.c);
a{4}.c=cab4(a{4}.c);

% Run continuation
a{4}=runauto(a{4});
 
%% Two-parameter continuation, follow locus of hopf point (Backward)
% Trace out the locus of the Hopf Bifurcation while stepping in a *backward*
% direction. We vary the first and the thrid parameters for the 
% continuation, so restart from label 4 in this first continuation, 
% hence we need to copy the restart file from the first run to the 
% appropriate name. Create new object and set constants
a{5}=a{1};
a{5}.c=copy(a{5}.c);
a{5}.c=cab5(a{5}.c);

% Run continuation
a{5}=runauto(a{5});

%% Plot the locii of the limit points and Hopf bifurcation
% Add the locii of the limit points and Hopf bifurcation
ploteq(p,a);
snapnow;
close(gcf);


displayEndOfDemoMessage(mfilename)
