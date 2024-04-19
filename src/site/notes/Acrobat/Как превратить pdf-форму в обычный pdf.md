---
{"dg-publish":true,"dg-permalink":"pdf-form-to-regular-pdf","permalink":"/pdf-form-to-regular-pdf/","tags":["FAQ","pdf"],"created":"2024-04-19T21:48:34.880+07:00","updated":"2024-04-19T21:54:56.211+07:00"}
---

Бывает такое, что есть пдф-форма с заполненными полями, а из неё надо сделать обычный пдф, и чтобы поля остались заполненными, но чтобы это уже была не форма.

Делается через оптимизацию. Заходим в меню `File` - `Save As Other` - `Optimized PDF` - в окне параметров оптимизации пункт `Discard Objects` - поставить галочку `Flatten form fields`, после нажатия `OK` будет предложено сохранить с другим именем файла.

![acrobat-flatten-form-fields.png](/img/user/assets/acrobat-flatten-form-fields.png)