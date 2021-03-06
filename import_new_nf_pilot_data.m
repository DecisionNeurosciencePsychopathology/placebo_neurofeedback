% import_new_nf_pilot_data

cd('~/Google Drive/skinner/Pecina_k/new_task_design/Behavioral/')
% subs = ls 
d = dir(pwd);
isub = [d(:).isdir]; %# returns logical vector
nameFolds = {d(isub).name}';
%remove . and ..
nameFolds(ismember(nameFolds,{'.','..','.git'})) = [];

% data = [];
% for sub = 1:length(nameFolds)
%     curdir = char(nameFolds(sub));
%     cd(curdir)
%     l = (what(pwd));
%     file = l.mat;
%     b = load(char(file));
%     b.RunDesign(:,1) = cellstr(num2str(sub));
%     data = [data; b.RunDesign];
%     cd('../')
% end

% b = cell2table(data);
% for sub = 1:
cd('1');
data = readtable('1_V1_Run_01_20170118_150617.csv');
cd('../2');
data = [data; readtable('2_V2_Run_01_20170118_153227.csv')];
cd('../3');
data = [data; readtable('3_V3_Run_01_20170118_155821.csv')];
cd('../4');
data = [data; readtable('7_V4_Run_01_20170120_133616.csv')];

% rename for brevity
b = data;
b.atrials = b.InfusionNum ==1;
b.btrials = b.InfusionNum ==2;
b.ctrials = b.InfusionNum ==3;
b.dtrials = b.InfusionNum ==4;
figure(2);clf; 
plot(smooth(2-b.WillImpResp(b.atrials))); hold on;
plot(smooth(2-b.WillImpResp(b.btrials)))
plot(smooth(2-b.WillImpResp(b.ctrials)))
plot(smooth(2-b.WillImpResp(b.dtrials))); hold off

% plot learning curves for stim A for each subject
pts = unique(b.Participant);
ntrials = 72;
a_stim_ratings = NaN(length(pts),ntrials/4);
b_stim_ratings = NaN(length(pts),ntrials/4);
c_stim_ratings = NaN(length(pts),ntrials/4);
d_stim_ratings = NaN(length(pts),ntrials/4);

for sub = 1:length(pts)
    a_stim_ratings(sub,:) = 2 - b.WillImpResp(b.Participant==pts(sub) & b.atrials);
    b_stim_ratings(sub,:) = 2 - b.WillImpResp(b.Participant==pts(sub) & b.btrials);
    c_stim_ratings(sub,:) = 2 - b.WillImpResp(b.Participant==pts(sub) & b.ctrials);
    d_stim_ratings(sub,:) = 2 - b.WillImpResp(b.Participant==pts(sub) & b.dtrials);

end
figure(1);clf;
for sub = 1:4;
subplot(1,4,sub)
plot(smooth(a_stim_ratings(sub,:))'); axis([0 18 0 1])
hold on;
plot(smooth(b_stim_ratings(sub,:))')
plot(smooth(c_stim_ratings(sub,:))', '*')
plot(smooth(d_stim_ratings(sub,:))', '*')
hold off; 
end

figure(2);clf;

subplot(1,4,1)
plot(smooth(a_stim_ratings(1,:))', 'b'); hold on; axis([0 18 0 1]); title('A')
plot(smooth(a_stim_ratings(2,:))', 'b')
plot(smooth(a_stim_ratings(3,:))', 'b')
plot(smooth(a_stim_ratings(4,:))', 'b');
plot(smooth(nanmean((a_stim_ratings))), 'b', 'LineWidth', 5); hold off;

subplot(1,4,2)
plot(smooth(b_stim_ratings(1,:))', 'r'); hold on;axis([0 18 0 1]); title('B')
plot(smooth(b_stim_ratings(2,:))', 'r')
plot(smooth(b_stim_ratings(3,:))', 'r')
plot(smooth(b_stim_ratings(4,:))', 'r'); 
plot(smooth(nanmean((b_stim_ratings))), 'r', 'LineWidth', 5); hold off;


subplot(1,4,3)
plot(smooth(c_stim_ratings(1,:))','g'); hold on; axis([0 18 0 1]); title('C')
plot(smooth(c_stim_ratings(2,:))', 'g')
plot(smooth(c_stim_ratings(3,:))','g')
plot(smooth(c_stim_ratings(4,:))','g');
plot(smooth(nanmean((c_stim_ratings))), 'g', 'LineWidth', 5); hold off;


subplot(1,4,4)
plot(smooth(d_stim_ratings(1,:))'); hold on;axis([0 18 0 1]); title('D')
plot(smooth(d_stim_ratings(2,:))', 'm')
plot(smooth(d_stim_ratings(3,:))', 'm')
plot(smooth(d_stim_ratings(4,:))', 'm'); 
plot(smooth(nanmean((d_stim_ratings))), 'm', 'LineWidth', 5); hold off;


% plot feedback ratings
a_feed_ratings = NaN(length(pts),ntrials/4);
b_feed_ratings = NaN(length(pts),ntrials/4);
c_feed_ratings = NaN(length(pts),ntrials/4);
d_feed_ratings = NaN(length(pts),ntrials/4);

for sub = 1:length(pts)
    a_feed_ratings(sub,:) = 2 - b.ImprovedResp(b.Participant==pts(sub) & b.atrials);
    b_feed_ratings(sub,:) = 2 - b.ImprovedResp(b.Participant==pts(sub) & b.btrials);
    c_feed_ratings(sub,:) = 2 - b.ImprovedResp(b.Participant==pts(sub) & b.ctrials);
    d_feed_ratings(sub,:) = 2 - b.ImprovedResp(b.Participant==pts(sub) & b.dtrials);

end
figure(3);clf;
for sub = 1:4;
subplot(1,4,sub)
plot(smooth(a_feed_ratings(sub,:))')
hold on;
plot(smooth(b_feed_ratings(sub,:))')
plot(smooth(c_feed_ratings(sub,:))', '*-')
plot(smooth(d_feed_ratings(sub,:))', '*-')
hold off; 
title('Feedback ratings')
end



figure(4);clf;

subplot(1,4,1)
plot(smooth(a_feed_ratings(1,:))', 'b'); hold on; axis([0 18 0 1])
plot(smooth(a_feed_ratings(2,:))', 'b')
plot(smooth(a_feed_ratings(3,:))', 'b')
plot(smooth(a_feed_ratings(4,:))', 'b')
plot(smooth(nanmean((a_feed_ratings))), 'b', 'LineWidth', 5); hold off;


subplot(1,4,2)
plot(smooth(b_feed_ratings(1,:))', 'r'); hold on;axis([0 18 0 1])
plot(smooth(b_feed_ratings(2,:))', 'r')
plot(smooth(b_feed_ratings(3,:))', 'r')
plot(smooth(b_feed_ratings(4,:))', 'r'); 
plot(smooth(nanmean((b_feed_ratings))), 'r', 'LineWidth', 5); hold off;


subplot(1,4,3)
plot(smooth(c_feed_ratings(1,:))', 'g'); hold on; axis([0 18 0 1])
plot(smooth(c_feed_ratings(2,:))', 'g')
plot(smooth(c_feed_ratings(3,:))', 'g')
plot(smooth(c_feed_ratings(4,:))', 'g'); 
plot(smooth(nanmean((c_feed_ratings))), 'g', 'LineWidth', 5); hold off;


subplot(1,4,4)
plot(smooth(d_feed_ratings(1,:))', 'm'); hold on;axis([0 18 0 1])
plot(smooth(d_feed_ratings(2,:))', 'm')
plot(smooth(d_feed_ratings(3,:))', 'm')
plot(smooth(d_feed_ratings(4,:))', 'm'); 
plot(smooth(nanmean((d_feed_ratings))), 'm', 'LineWidth', 5); hold off;

title('Feedback ratings: subplot = stimulus, line = subject')

figure(5)
subplot(1,2,1);
plot(smooth(nanmean((a_stim_ratings))), 'LineWidth', 5); hold on;
plot(smooth(nanmean((b_stim_ratings))), 'LineWidth', 5); 
plot(smooth(nanmean((c_stim_ratings))),'LineWidth', 5); 
plot(smooth(nanmean((d_stim_ratings))),'LineWidth', 5); hold off;
 title('Mean expectancy ratings'); legend('drug A', 'drug B', 'cal. C', ' cal. D')
 
subplot(1,2,2);
plot(smooth(nanmean((a_feed_ratings))),  'LineWidth', 5); hold on;
plot(smooth(nanmean((b_feed_ratings))),  'LineWidth', 5); 
plot(smooth(nanmean((c_feed_ratings))),  'LineWidth', 5); 
plot(smooth(nanmean((d_feed_ratings))),  'LineWidth', 5); hold off;
 title('Mean neuro-feedback ratings'); legend('drug A', 'drug B', 'cal. C', ' cal. D')

 
figure(6)
subplot(1,2,1);
plot((nanmean((a_stim_ratings))),'*:', 'LineWidth', 2); hold on;
plot((nanmean((b_stim_ratings))),'*:', 'LineWidth', 2); 
plot((nanmean((c_stim_ratings))),'*:', 'LineWidth', 2); 
plot((nanmean((d_stim_ratings))),'*:','LineWidth', 2); hold off;
 title('Unsmoothed mean expectancy ratings'); legend('drug A', 'drug B', 'cal. C', ' cal. D')
 
subplot(1,2,2);
plot((nanmean((a_feed_ratings))),'*:',  'LineWidth', 2); hold on;
plot((nanmean((b_feed_ratings))), '*:', 'LineWidth', 2); 
plot((nanmean((c_feed_ratings))),  '*:','LineWidth', 2); 
plot((nanmean((d_feed_ratings))),  '*:','LineWidth', 2); hold off;
 title('Unsmoothed mean neuro-feedback ratings'); legend('drug A', 'drug B', 'cal. C', ' cal. D')

 
% save data
 cd('../')
writetable(b,'pilot_behav','FileType','text')
 