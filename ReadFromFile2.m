function[A,order,xrequire,counter] =ReadFromFile2()
order=0;xrequire=0;counter=0;
 [file,path] = uigetfile('*.txt');
 A=[];
  if isequal(file,0)
      disp('User selected Cancel');
      return;
  else
i=1;
ffile =fopen(file);
tline=fgetl(ffile);
while ischar(tline)
    if(strcmp(tline,'points'))
        counter=counter+1;
        tline=fgetl(ffile);
        while((~strcmp(tline,'order'))&&(~strcmp(tline,'xrequire')))
            arr=strsplit(tline,' ');
            A(i,1)=str2double(arr(1)); 
            A(i,2)=str2double(arr(2));
            tline=fgetl(ffile);
            i=i+1;
        end
    elseif(strcmp(tline,'order'))
        counter=counter+1;
        tline=fgetl(ffile);
        order=tline;
        tline=fgetl(ffile);
    elseif(strcmp(tline,'xrequire'))
        counter=counter+1;
        tline=fgetl(ffile);
        xrequire=tline;
        tline=fgetl(ffile);
    else
        disp('wrong input :(');
    end
end
fclose(ffile);
  end
end