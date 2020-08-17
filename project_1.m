%STEP 1 : READ AUDIO FILE
[y,Fs] = audioread('music.wav');
%sound(y,Fs)    %listen to file

%STEP 2 : COMBINING LEFT AND RIGHT CHANNEL INTO FUNCTION x(t)
xt = mean(y,2); %stereo to mono conversion

t = 1/Fs:1/Fs:length(xt)/Fs; %set time samples


%STEP 3: PLOT MONO AUDIO FUNCTION - x(t)
figure(1)
plot(t,xt)
title('MONO VERSION OF ORGINAL AUDIO SIGNAL - x(t)')
xlabel('time')
ylabel('amplitude')

%STEP 4A,5A: TRANSFER FUNCTION - RL SERIES AND C PARALLEL
ht = 4259.69*(exp(-3171.11*t) - exp(-12408.9*t));

%step 6A -- Plotting transfer function
figure(2)
plot(t,ht)
xlim([0,0.05])
ylim([0,0.05])
title('LOW PASS RLC FILTER TRANSFER FUNCTION')
xlabel('time')
ylabel('amplitude')

%step 7A : convolution
yt =  conv(xt,ht,'same');

ymax=max(abs(yt));
yt=yt/ymax;
%Plotting output
figure(3)
plot(t,yt)
title('LOW PASS FILTER OUTPUT')
xlabel('time')
ylabel('amplitude')
 
%step 8A: exporting filtered audio
audiowrite('output_low_pass.wav',yt,Fs);
[y1,Fs] = audioread('output_low_pass.wav');
%sound(y1,Fs)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%STEP 4B,5B: TRANSFER FUNCTION - RC SERIES AND L PARALLEL
ht_2 = dirac(t) + 1087.12*exp(-3170.1*t) - 16671.5*exp(-12414.2*t);

%step 6B -- Plotting transfer function
figure(4)
plot(t,ht_2)
xlim([0,0.05])
ylim([0,0.05])
title('HIGH PASS RLC FILTER TRANSFER FUNCTION')
xlabel('time')
ylabel('amplitude')

%step 7B : convolution
yt_2 =  conv(xt,ht_2,'same');

ymax_2=max(abs(yt_2));
yt_2=yt_2/ymax_2;
%Plotting output
figure(5)
plot(t,yt_2)
title('HIGH PASS FILTER OUTPUT')
xlabel('time')
ylabel('amplitude')
 
%step 8B: exporting filtered audio
audiowrite('output_high_pass.wav',yt_2,Fs);
[y2,Fs] = audioread('output_high_pass.wav');
 
%sound(y2,Fs)










