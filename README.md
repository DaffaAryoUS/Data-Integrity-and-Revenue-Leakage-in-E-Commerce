# Data Integrity & Revenue Leakage in E-Commerce 📦📊

## 📌 Project Overview

Proyek ini bertujuan untuk menganalisis performa bisnis e-commerce menggunakan dataset Olist dengan pendekatan SQL. Fokus utama analisis tidak hanya pada distribusi pelanggan dan pendapatan, tetapi juga pada **data integrity issue**, ketimpangan pasar geografis, serta potensi **revenue leakage** yang dapat memengaruhi pengambilan keputusan bisnis.

Analisis ini mengungkap bagaimana kualitas data yang buruk dapat menyebabkan bias dalam insight serta berpotensi menurunkan akurasi strategi bisnis, khususnya dalam konteks distribusi pelanggan, logistik, dan peluang ekspansi pasar.

---

## ⚠️ Problem Statement

Dalam industri e-commerce, keputusan bisnis yang bergantung pada data sangat rentan terhadap kesalahan jika kualitas data tidak terjaga.

Pada dataset Olist, ditemukan indikasi kuat adanya:

* **Data tidak terhubung (orphan data)** dalam jumlah besar
* Ketimpangan distribusi pelanggan yang terpusat di wilayah tertentu
* Potensi kehilangan pendapatan akibat data yang tidak dapat dilacak

Masalah ini berpotensi menyebabkan:

* Bias dalam analisis customer behavior
* Kesalahan dalam strategi ekspansi geografis
* Ketidaktepatan dalam evaluasi performa bisnis

---

## 📂 About Data

* **Dataset:** Olist E-Commerce Dataset
* **Format:** CSV (diolah menggunakan SQL)
* **Domain:** Brazilian E-Commerce
* **Sumber:** Kaggle

Dataset mencakup berbagai aspek operasional e-commerce, seperti:

* Customer
* Orders
* Payments
* Sellers
* Products
* Geolocation

---

## 🛠️ Tech Stack & Tools

* **Query Language:** SQL
* **Database:** PostgreSQL / MySQL
* **Data Processing:** SQL Query (JOIN, Aggregation, Filtering)
* **Environment:** DBMS / SQL Client Tools

---

## 💡 Key Insights

### 1. Data Integrity Issue: Orphan Data yang Masif

* Ditemukan bahwa sekitar **85% data tidak memiliki relasi yang lengkap (orphan data)**
* Hal ini mengindikasikan adanya masalah serius dalam proses data collection atau ETL
* Dampak: analisis menjadi tidak representatif dan berisiko menghasilkan insight yang bias

---

### 2. Ketimpangan Distribusi Pelanggan (Geographical Imbalance)

* Wilayah **São Paulo** mendominasi jumlah pelanggan secara signifikan
* Menunjukkan adanya ketergantungan tinggi terhadap satu wilayah utama
* Risiko: overfitting strategi bisnis pada satu market saja

---

### 3. Revenue Leakage akibat Data Tidak Teridentifikasi

* Sebagian transaksi tidak dapat ditelusuri dengan baik karena missing relationship antar tabel
* Hal ini mengindikasikan adanya **potensi revenue yang tidak tercatat secara optimal**
* Dampak langsung pada akurasi pelaporan keuangan dan performa bisnis

---

### 4. Peluang Ekspansi di Wilayah Non-Dominan

* Wilayah seperti **Brasília dan Pará** menunjukkan potensi pertumbuhan
* Meskipun volume saat ini rendah, terdapat indikasi peluang market expansion
* Insight ini membuka peluang diversifikasi strategi geografis

---

## 🚀 Actionable Recommendations

1. **Perbaikan Data Pipeline & Integrity Check**

   * Implementasi validasi relasi antar tabel (foreign key consistency)
   * Audit proses ETL untuk mengurangi orphan data

2. **Rekonstruksi Data Model untuk Analisis yang Lebih Akurat**

   * Membersihkan dan memfilter data invalid sebelum analisis
   * Membuat dataset turunan (*clean dataset*) sebagai baseline analisis

3. **Diversifikasi Strategi Geografis**

   * Mengurangi ketergantungan pada São Paulo
   * Mengembangkan strategi penetrasi di wilayah potensial seperti Brasília dan Pará

4. **Monitoring Revenue Leakage**

   * Membangun sistem tracking untuk transaksi yang tidak teridentifikasi
   * Mengintegrasikan validasi data pada setiap tahap pipeline

---

## 📈 Conclusion

Analisis ini menunjukkan bahwa **kualitas data memiliki dampak langsung terhadap kualitas insight bisnis**. Tanpa data integrity yang baik, perusahaan berisiko mengambil keputusan strategis yang tidak akurat.

Dengan memperbaiki struktur data dan memperluas fokus analisis ke wilayah non-dominan, perusahaan dapat:

* Mengurangi bias analisis
* Mengoptimalkan potensi revenue
* Meningkatkan efektivitas strategi ekspansi

---

