#!/bin/bash
output_file="yxfilter.txt"
> "$output_file"  # เคลียร์ไฟล์ก่อนเริ่มต้น
echo "Cleared $output_file"

all_content=""

for file in filter/*.txt; do
    if [ -f "$file" ]; then
        echo "Processing $file..."

        # เรียงบรรทัด และลบบรรทัดว่างออก
        sorted_content=$(sort "$file" | grep .)

        # บันทึกเฉพาะบรรทัดที่ไม่ว่างกลับไปยังไฟล์ต้นฉบับ
        echo "$sorted_content" > "$file"
        echo "Sorted $file"

        # ดึงชื่อไฟล์โดยตัด ".txt" ออกและเพิ่ม ! ข้างหน้า
        filename="! $(basename "$file" .txt)"

        # รวมเนื้อหาทั้งหมดไว้ก่อน
        all_content+="$filename"$'\n'
        all_content+="$sorted_content"$'\n\n'
    fi
done

# บันทึกเนื้อหาทั้งหมดลง yxfilter.txt ทีเดียว
echo -n "$all_content" >> "$output_file"
echo "Saved all sorted content to $output_file"

echo ""
read -p "Enter to close..."
