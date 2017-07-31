%clear  
load Data4Alex
maxit=300000;
maxeval=300000;
%maxlike=30; % number of searches
        
    op=optimset('fminsearch');
    op.MaxIter=maxit;
    op.MaxFunEvals=maxeval;
    op.TolX=1e-10;
    op.TolFun=1e-10;
    %op.Display='iter'; 

op.Simplex = 'on';
op.Algorithm = 'active-set';    

 %   xpar_f2 = [];
 %   like_f2 = 0;
    lb=[0,0,0,0,0,0,0,-inf]; 
    ub=[+inf,+inf,1,1,1,1,1,+inf];
x0 = [.5 .5 .5 .5 .5 .5 .5 0];
%numParams = 8;


Q=@(x)DAW_MFMB_Model_032014_AJ(x(1),x(2),x(3),x(4),x(5),x(6),x(7),x(8),data);
[xvalues fvalues exits starts]= rmsearch(Q,'fminsearchbnd',x0,lb,ub,'options',op);



clear i j