function level = otsu(histogramCounts, total)%histogramCounts��ͼ���ֱ��ͼ, totalͼ�����������
sum0 = 0;
w0 = 0;%���ظ���
maximum = 0.0;%����T�����ֵ
total_value = sum((0:255).*histogramCounts');
for ii=1:256
    w0 = w0 + histogramCounts(ii);%<T���ظ����ۼ�
    if (w0 == 0)
        continue;
    end
    w1 = total - w0;
    if (w1 == 0)%��������>T����=0
        break;
    end
    sum0 = sum0 +  (ii-1) * histogramCounts(ii);%�ҶȺ�
    m0 = sum0 / w0;%ƽ�ֻҶ�u0
    m1 = (total_value - sum0) / w1;%ƽ�ֻҶ�u1
    icv = w0 * w1 * (m0 - m1) * (m0 - m1);
    if ( icv >= maximum )
        level = ii;
        maximum = icv;
    end
end
end