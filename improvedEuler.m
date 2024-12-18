m=inputdlg('Enter the 1st order ODE or slope function:');
s=m{:};
d=str2func(['@(x,y)' s]);
f=str2func(['@(x,y)' vectorize(s)]);
x=input('Select the initial x value:');
y=input('Select the initial y value:');
h=input('Select the increment value:');

n=0;
term=0;
check=0;
X=x;


while (term<1)||(term>2)
    term=input('Please choose what termination criteria you desire.\nPress "1" for a specified x value and "2" for nth iteration:');
    if term==1
        val=input('The specified x value is:');
        itr=(val-x)/h;
        break;
    end
    if term==2
        itr=input('The desired nth iteration (iterations will start from n=0) is:');
        break;
    end
    fprintf('Wrong input! Please try again.\n\n');   
end
fprintf('\n');

q='itern';
w='x value';
b='current y';
c='predictor y';
j='solved y';
o='current slope';
O='predict. slope';
J='Avg. slope';
k='      ';
K='   ';
a=[q,k,w,k,b,K,c,k,j,K,o,K,O,k,J];
disp(a);

for i=1:1000
    l=x;
    t=y;
    p=y;
    fr=f(l,y);
    p=p+(h*fr);
    x=x+h;
    fp=f(x,p);
    avg=0.5*(fr+fp);
    y=y+(h*avg);
    fprintf('%3.0f %13.4f %13.4f %13.4f %13.4f %13.4f %17.4f %17.4f\n',n,l,t,p,y,fr,fp,avg);
    mat1(i,1)=l;
    mat2(i,1)=t;
    if n>=itr break;
    end
    
    n=n+1;
end

if term==1
fprintf('\nThe specified x value of %f is now reached at %.0fth iteration, with a y value of %.4f\n',val,n,t);
end
if term==2
fprintf('\nThe desired %.0fth iteration is now reached at an x value of %f, with a y value of %.4f\n',itr,l,t);
end


while (check<1)||(check>2)
    check=input('\nIs the actual solution curve readily available? Choose "1" for yes or "2" for no:');
    N=0;
    if check==2
    M=inputdlg('Enter the actual solution curve function:'); 
    S=M{:};
    D=str2func(['@(x)' S]);
    F=str2func(['@(x)' vectorize(S)]);  
    fprintf('\n');
    
    
    q='itern';
    o='x value';
    w='estimated y';
    b='actual y';
    c='abs. error';
    j='%rel. error';
    k='     ';
    a=[q,k,o,k,w,k,b,k,c,k,j];
    disp(a);
    
    for i=1:n+1
        fX=F(X);
        X=X+h;
        g=abs(mat2(i,1)-fX);
        e=(g/fX)*100;
        fprintf('%2.0f %13.4f %13.4f %13.4f %13.4f %16.4f\n',N,mat1(i,1),mat2(i,1),fX,g,e);
        N=N+1;
    end
    fprintf('\nWhen x is %.4f, the actual y value is %.4f. The percent relative error is %.4f\n',mat1(i,1),fX,e);
    break;
    end
    if check==2
        fprintf('\nThe program is now terminated.\n');
        break;
    end
    fprintf('Wrong input! Please try again.');
end
      
return      