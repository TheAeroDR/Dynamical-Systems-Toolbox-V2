      function []= stpnt(ndim,u,par) 
%                      
% 
% 
      p1=0.5;
      p2=4;
      p3=0.9;
      p4=2.;
%
      u(1)=p3;
      u(2)=-p4*(p3**3/3-p3);
      u(3)=p3;
% 
      par(1)=p1;
      par(2)=p2;
      par(3)=p3;
      par(4)=p4;
% 
      return 
