---
{"dg-publish":true,"dg-permalink":"about-stable-diffusion","permalink":"/about-stable-diffusion/","pinned":true,"created":"2023-10-29T21:51:18.536+07:00","updated":"2024-03-03T12:19:18.883+07:00"}
---

В этом разделе я расскажу о своём небольшом опыте использования этой нейросети для генерации изображений.

Ставится Stable diffusion на комп. Нужна крепкая видюха, в смысле, примерно на уровне чтобы запускались современные игры. У меня 1060.  
  
Сначала я бессмысленно ковырялся, пока не наткнулся на [Хруста]([https://youtube.com/@XpucT](https://youtube.com/@XpucT)). В принципе, на его канале есть всё, включая [портабельный дистриб Stable Diffision от a1111](https://github.com/serpotapov/stable-diffusion-portable). И если sd - это база в нейросетевой генерации изображений, то вариант от a1111 - это база базы.  Ну а вариант установочных файлов от Хачатура, который Xpuct - это база базы базы.
  
Если упрощённо, то Stable diffusion устроен так. Есть сам программный комплекс, который управляет генерацией. В нём есть разные составляющие, самая важная из которых - это базовая модель, она же *checkpoint*. Чекпоинт содержит в себе результат обучения на картинках, то есть некоторую базу данных, которая говорит нейросети о том, как по данному промту рисовать картинку. Чекпоинтов много разных, их можно менять под задачи. Я пользуюсь практически одной моделью, от того же Хруста, которая [Deliberate](https://huggingface.co/XpucT/Deliberate/tree/main).
  
На основе базовой модели можно выполнять несколько действий: *txt2img* - генерация картинки по промту (по текстовому описанию), *img2img* - генерация картинки на основе существующей, *inpaint* - изменение частей картинки и *sketch* - генерация картинки по наброску. Для inpaint, как правило, нужен особый чекпоинт, специально для инпаинтинга.  
  
Кроме базовой модели, есть вспомогательные, которые подключаются дополнительно к базовой, для того, чтобы её в расширить в нужном направлении - грубо говоря, там либо дополнительные изображения, либо дополнительные стили. Эти модели бывают разных форматов - *Lora*, *embedding*...  
  
Дополнительно, для стейбла есть must-have плагины, без который не то чтобы никак, но сильно упрощают жизнь (удлинняя время генерации :))) Например есть комплекс всяких дополнительных фич для генерации - [ControlNet](https://github.com/Mikubill/sd-webui-controlnet), у неё свои доп. модели, позволяет, например, сгенерировать картинку в стиле другой картинки, или взять какие-то её черты, или общий стиль, или даже изменить в нужном направлении. Есть [ADetailer](https://github.com/Bing-su/adetailer) для более тщательной дорисовки лиц. Есть [FaceSwapLab](https://github.com/glucauze/sd-webui-faceswaplab), которую можно обучить на фотках человека и она будет гармонично подрисовывать в сгенерённые изображения его лицо.  
  
Работа со стебйлом (у меня) в общих чертах устроена так. Сначала генерятся варианты небольшого размера - подбирается и оттачивается промпт. Как вариант - можно брать за основу какую-то существующую картинку - то есть сразу идти либо в *img2img* или с помощью *ControlNet*. Если никак не получается какой-то элемент картинки - двигаемся в инпаинт и там догенерируем в нужной области. Как только получилась удачная картинка - увеличиваем через встроенную увеличилку в *extras*, а потом на основе увеличенной картинки в *img2img* генерим финальную большую - это медленно, поэтому сразу так делать не вариант, если у вас, конечно, не видюха 4090.