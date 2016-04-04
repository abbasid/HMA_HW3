%% Question 1
R = struct;
R.xyx = RotFormula('xyx');
R.xyz = RotFormula('xyz');
R.xzx = RotFormula('xzx');
R.xzy = RotFormula('xzy');
R.yxy = RotFormula('yxy');
R.yxz = RotFormula('yxz');
R.yzx = RotFormula('yzx');
R.yzy = RotFormula('yzy');
R.zxy = RotFormula('zxy');
R.zyx = RotFormula('zyx');
R.zxz = RotFormula('zxz');
R.zyz = RotFormula('zyz');
% save as a matlab structure
save RotationMatrix.mat R;

%% Question 2
load('DataQ1');
lPcoord = cat(3, RASI, LASI, RPSI);
lTcoord = cat(3, LTRO, LLFC, LMFC);
rTcoord = cat(3, RTRO, RLFC, LMFC);
lScoord = cat(3, LTT, LSHA, LLMA, LMMA);
rScoord = cat(3, RTT, RSHA, RLMA, RMMA);
lFcoord = cat(3, LHEE, LFOO, LTOE);
rFcoord = cat(3, RHEE, RFOO, RTOE);

P_MKstr = {'RASI', 'LASI', 'RPSI'};
lT_MKstr = {'LTRO', 'LLFC', 'LMFC'};
rT_MKstr = {'RTRO', 'RLFC', 'RMFC'};
lS_MKstr = {'LTT', 'LSHA', 'LLMA', 'LMMA'};
rS_MKstr = {'RTT', 'LSHA', 'LLMA', 'LMMA'};
lF_MKstr = {'LHEE', 'LFOO', 'LTOE'};
rF_MKstr = {'RHEE', 'RFOO', 'RTOE'};

[lRg2p, lVg2p, lPcoord_local] = CoordPelvis(lPcoord, 'L', P_MKstr);
[rRg2p, rVg2p, rPcoord_local] = CoordPelvis(lPcoord, 'r', P_MKstr);
[lRg2t, lVg2t, lTcoord_local] = CoordThigh(lTcoord, 'l', lT_MKstr);
[rRg2t, rVg2t, rTcoord_local] = CoordThigh(rTcoord, 'r', rT_MKstr);
[lRg2s, lVg2s, lScoord_local] = CoordShank(lScoord, 'l', lS_MKstr);
[rRg2s, rVg2s, rScoord_local] = CoordShank(rScoord, 'r', rS_MKstr);
[lRg2f, lVg2f, lFcood_local] = CoordFoot(lFcoord, 'l', lF_MKstr);
[rRg2f, rVg2f, rFcoord_local] = CoordFoot(rFcoord, 'r', rF_MKstr);

lRp2t = zeros(size(lRg2p));
rRp2t = zeros(size(lRg2p));
lRt2s = zeros(size(lRg2p));
rRt2s = zeros(size(lRg2p)); 
lRs2f = zeros(size(lRg2p)); 
rRs2f = zeros(size(lRg2p));

% 計算旋轉矩陣
for i = 1 : size(lRg2p, 3)
    lRp2t(:, :, i) = lRg2p(:, :, i)' * lRg2t(:, :, i);
    rRp2t(:, :, i) = rRg2p(:, :, i)' * rRg2t(:, :, i);
    lRt2s(:, :, i) = lRg2t(:, :, i)' * lRg2s(:, :, i);
    rRt2s(:, :, i) = rRg2t(:, :, i)' * rRg2s(:, :, i);
    lRs2f(:, :, i) = lRg2s(:, :, i)' * lRg2f(:, :, i);
    rRs2f(:, :, i) = rRg2s(:, :, i)' * rRg2f(:, :, i);
end

% 計算旋轉角度
theta_lp2t = Rot2Ang(lRp2t, 'zxy');
theta_rp2t = Rot2Ang(rRp2t, 'zxy');
theta_lt2s = Rot2Ang(lRt2s, 'zxy');
theta_rt2s = Rot2Ang(rRt2s, 'zxy');
theta_ls2f = Rot2Ang(lRs2f, 'zxy');
theta_lt2f = Rot2Ang(rRs2f, 'zxy');

theta_lp2t_yxz = Rot2Ang(lRp2t, 'yxz');
theta_rp2t_yxz = Rot2Ang(rRp2t, 'yxz');
theta_lt2s_yxz = Rot2Ang(lRt2s, 'yxz');
theta_rt2s_yxz = Rot2Ang(rRt2s, 'yxz');
theta_ls2f_yxz = Rot2Ang(lRs2f, 'yxz');
theta_lt2f_yxz = Rot2Ang(rRs2f, 'yxz');

% Question 2-i
isequal_lRp2t = isequal(RotAngConvert(RotAngConvert(lRp2t, 'zxy'), 'zxy'), lRp2t);
disp(isempty(isequal_lRp2t));
isequal_rRp2t = isequal(RotAngConvert(RotAngConvert(rRp2t, 'zxy'), 'zxy'), rRp2t);
isequal_lRt2s = isequal(RotAngConvert(RotAngConvert(lRt2s, 'zxy'), 'zxy'), lRt2s);
isequal_rRt2s = isequal(RotAngConvert(RotAngConvert(rRt2s, 'zxy'), 'zxy'), rRt2s);
isequal_lRs2f = isequal(RotAngConvert(RotAngConvert(lRs2f, 'zxy'), 'zxy'), lRs2f);
isequal_rRs2f = isequal(RotAngConvert(RotAngConvert(rRs2f, 'zxy'), 'zxy'), rRs2f);
% Question 2-ii
isequal_lRp2t2 = isqual(circshift(theta_lp2t, [0, 2]), theta_lp2t_yxz);
isequal_rRp2t2 = isqual(circshift(theta_rp2t, [0, 2]), theta_rp2t_yxz);
isequal_lRt2s2 = isqual(circshift(theta_lt2s, [0, 2]), theta_lt2s_yxz);
isequal_rRt2s2 = isqual(circshift(theta_rt2s, [0, 2]), theta_rt2s_yxz);
isequal_lRs2f2 = isqual(circshift(theta_ls2f, [0, 2]), theta_ls2f_yxz);
isequal_rRs2f2 = isqual(circshift(theta_rs2f, [0, 2]), theta_rs2f_yxz);


