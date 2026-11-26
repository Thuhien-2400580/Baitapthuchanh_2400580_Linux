#!/bin/bash

FILE=~/2400580_hien_Linux/data/sinhvien.txt

# Kiểm tra file dữ liệu
if [ ! -f "$FILE" ]
then
    echo "Khong tim thay file du lieu!"
    exit 1
fi

while true
do
    echo
    echo "===== CHUONG TRINH QUAN LY SINH VIEN ====="
    echo "1. Hien thi danh sach sinh vien"
    echo "2. Tim kiem sinh vien theo ma"
    echo "3. Thong ke sinh vien dat va khong dat"
    echo "4. Tinh diem trung binh"
    echo "5. Hien thi sinh vien co diem cao nhat"
    echo "6. Sap xep sinh vien theo diem giam dan"
    echo "0. Thoat chuong trinh"

    read -p "Nhap lua chon: " chon

    case $chon in
        1)
            echo "=== DANH SACH SINH VIEN ==="
            cat "$FILE"
            ;;
            
        2)
            read -p "Nhap ma sinh vien: " ma
            ketqua=$(grep "^$ma:" "$FILE")

            if [ -n "$ketqua" ]
            then
                echo "$ketqua"
            else
                echo "Khong tim thay sinh vien co ma $ma"
            fi
            ;;
            
        3)
            dat=$(awk -F: '$3>=5 {d++} END {print d+0}' "$FILE")
            khongdat=$(awk -F: '$3<5 {k++} END {print k+0}' "$FILE")

            echo "So sinh vien dat: $dat"
            echo "So sinh vien khong dat: $khongdat"
            ;;
            
        4)
            awk -F: '
            {
                tong += $3
                dem++
            }
            END {
                if (dem > 0)
                    printf "Diem trung binh: %.2f\n", tong/dem
                else
                    print "Khong co du lieu."
            }' "$FILE"
            ;;
            
        5)
            echo "=== SINH VIEN CO DIEM CAO NHAT ==="
            sort -t: -k3,3nr "$FILE" | head -1
            ;;
            
        6)
            echo "=== DANH SACH SAP XEP GIAM DAN THEO DIEM ==="
            sort -t: -k3,3nr "$FILE"
            ;;
            
        0)
            echo "Thoat chuong trinh..."
            exit 0
            ;;
            
        *)
            echo "Lua chon khong hop le!"
            ;;
    esac
done












