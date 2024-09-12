function level = otsu(histogramCounts, total)%histogramCounts是图像的直方图, total图像的总像素数
sum0 = 0;
w0 = 0;%像素个数
maximum = 0.0;%保存T的最大值
total_value = sum((0:255).*histogramCounts');
for ii=1:256
    w0 = w0 + histogramCounts(ii);%<T像素个数累加
    if (w0 == 0)
        continue;
    end
    w1 = total - w0;
    if (w1 == 0)%遍历结束>T像素=0
        break;
    end
    sum0 = sum0 +  (ii-1) * histogramCounts(ii);%灰度和
    m0 = sum0 / w0;%平局灰度u0
    m1 = (total_value - sum0) / w1;%平局灰度u1
    icv = w0 * w1 * (m0 - m1) * (m0 - m1);
    if ( icv >= maximum )
        level = ii;
        maximum = icv;
    end
end
end