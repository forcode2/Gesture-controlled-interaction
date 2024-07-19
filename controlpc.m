import java.awt.Robot;
import java.awt.event.*
mouse = Robot;
vid=videoinput('winvideo',1,'YUY2_480x800');
set(vid, 'FramesPerTrigger', Inf);
set(vid, 'ReturnedColorspace', 'rgb')
vid.FrameGrabInterval = 5;
start(vid);

while(vid.FramesAcquired<=100)
   data=getsnapshot(vid);
    diff_im = imsubtract(data(:,:,1), rgb2gray(data));
    diff_im1=imsubtract(data(:,:,3), rgb2gray(data));
    diff_im = im2bw(diff_im,0.18);
    diff_im1 = im2bw(diff_im1,0.18);
    diff_im = bwareaopen(diff_im,600);
     diff_im1 = bwareaopen(diff_im1,600);
    bw = bwlabel(diff_im, 8);
    bw1 = bwlabel(diff_im1, 8);
    [B,L,num]= bwboundaries(bw,'noholes');
    [P,Q,num1]=bwboundaries(bw1,'noholes');
      a = regionprops(L,'centroid');
    b=regionprops(Q,'centroid');
   imshow(data);
    if num >= 1 && num1==0
         
            %(a(2).Centroid(1,1)) - (a(1).Centroid(1,1));
            %movement of cursor
            mouse.mouseMove(2000-(a(1).Centroid(1,1)*(5/2)),(a(1).Centroid(1,2)*(5/2)-180));


    end   
   
if num1>=1 && num>=1
        if (a(1).Centroid(1,1)-b(1).Centroid(1,1)>50)
        %if the difference is positive then right click
        mouse.mousePress(InputEvent.BUTTON3_MASK);
        mouse.mouseRelease(InputEvent.BUTTON3_MASK);
       
        else if(a(1).Centroid(1,1)-b(1).Centroid(1,1)<-50)
        %if the difference is negative then left click
        mouse.mousePress(InputEvent.BUTTON1_MASK);
        mouse.mouseRelease(InputEvent.BUTTON1_MASK);
             end
        end
end
end
stop(vid);
flushdata(vid);
clear all;