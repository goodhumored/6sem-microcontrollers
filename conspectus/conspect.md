# MCS-51

MCS-51 (или 8051) – это семейство 8-разрядных микроконтроллеров (МК),
разработанное компанией Intel.

## Характеристики

- 8-разрядный процессор,
- внутренняя (встроенная) память программ (RAM), объем которой
зависит от модели МК,
- внутренняя память данных (RAM) объемом 265 байт,
- возможность подключения внешней памяти данных и программ до
64 Кбайт каждая,
- глубина стека 256 байт,
- 32 программируемых вывода (4 8-разрядных порта ввода-вывода),
- полнодуплексный последовательный порт,
- три 16-разрядных таймера/счетчика,
- 8 источников прерываний,
- битовый процессор (для работы с битами информации),
8
- 256 прямоадресуемых бит,
- есть операции умножения и деления,
- стандартная тактовая частота – 12 МГц.

![MCS-51](image-10.png)

## Выходы

* XTAIL1, XTAIL2 – выводы для подключения внешнего тактового
генератора;
* ALE/PROG, EA/VPP, PSEN, WR, RD – выводы для передачи управляющих
сигналов при использовании внешней памяти программ и данных (подробнее о
подключении внешней памяти см. в разделе 1.3), а также для записи в память
программ
* INT0, INT1 – входы внешних прерываний;
* T0, T1, T2, T2EX – выводы для подачи внешних сигналов таймерам-
счетчикам 0, 1 и 2;
* RxD, TxD – приемник и передатчик последовательного порта;
* P1.0…P1.7, P3.0…P3.7 – выводы двунаправленных 8-битных портов 1 и 3,
имеют альтернативные функции, связанные с периферийными устройствами;
* P0.0…P0.7, P2.0…P2.7 – выводы двунаправленных 8-битных портов 0 и 2,
выполняют альтернативные функции при подключении внешней памяти
программ и данных.

## Схема

![Схема МК](image-11.png)

## Архитектура центрального процессора

Центральный процессор большинства микроконтроллеров состоит из **дешифратора команд**, блока арифметико-логического устройства (**АЛУ**) и **блока управления программой**

**Дешифратор команд** производит декодирование команды и формирование управляющих сигналов, необходимых для ее выполнения.

Блок **АЛУ** производит большую часть операций над данными и состоит из арифметико-логического устройства, аккумулятора A, регистров B и PSW (подробнее см. раздел 1.3). АЛУ производит операции как над 8-битными данными, так и над отдельными битами.

**Блок управления программой** управляет последовательностью, в которой
выполняются команды, расположенные в памяти программ. 16-битный
программный счетчик PC (Program counter) содержит адрес следующей для
выполнения команды.

### Длительность цикла

Длительность машинного цикла в микроконтроллерах семейства MCS-51
составляет 12 тактовых импульсов. Все команды выполняются в течение одного
или двух машинных циклов за исключением команд умножения и деления,
выполнение которых занимает 4 машинных цикла (подробнее см. раздел 1.4).

## Организация памяти

Так как микроконтроллеры семейства MCS-51 реализованы в соответствии с гарвардской архитектурой, они имеют раздельные (физически и логически) адресные пространства памяти – ***память программ*** и ***память данных***.

### Память программ

*Память программ* **предназначена для хранения кода исполняемой микроконтроллером программы**. Эта память, как правило, является энергонезависимой (информация в ней сохраняется при выключении питания) и доступной только для чтения.

Объем внутренней памяти программ (IROM) семейства MCS-51 зависит от конкретной модели и составляет от 0 до 64 Кбайт. Для работы моделей, не имеющих внутренней памяти программ, необходимо подключение внешней памяти программ.

![Пространство памяти микроконтроллеров семейства MCS-51](image-12.png)

У любых МК семейства MCS-51 имеется возможность подключения внешней памяти программ объемом до 64 Кбайт.

Если на выводе $\bar{EA}$ микроконтроллера высокий уровень напряжения и значение программного счетчика PC не превышает максимальный адрес внутренней памяти программ, то МК обращается к внутренней памяти.

Если на выводе $\bar{EA}$ микроконтроллера низкий уровень напряжения или значение PC превышает максимальный адрес внутренней памяти программ, то МК обращается к внешней памяти программ.

При включении или сбросе МК, содержимое PC обнуляется и программа начинает выполняться с адреса **0h**. Этот адрес называется *вектором сброса МК*.

Блок памяти программ с адресами **03h – 2Bh** обычно содержит *векторы прерываний*. Нижняя граница блока векторов прерываний может отличаться для разных моделей МК, подробнее см. в описании работы, посвященной системе прерываний.

### Память данных

Большинство МК семейства MCS-51 имеют внутреннюю память данных объемом 256 байт. Кроме этого, также имеется возможность подключения внешней памяти данных объемом до 64 Кбайт.

На кристалле МК размещаются три физически разделенных блока внутренней памяти данных: **блок младших 128 байт IRAM с адресами *00 – 7Fh***,
**блок старших 128 байт IRAM с адресами *80h – FFh*** и **блок регистров специальных функций SFR, размещенный по адресам *80h – FFh*.**

Так как старшие 128 байт внутренней памяти данных и область SFR имеют одинаковое адресное пространство, для обращения к ним используют разные способы адресации.

![Адресация регистров](image-13.png)

Младшие 128 байт IRAM в отличие от других областей внутренней памяти данных в свою очередь подразделяются на три области (рис. 4).

Первые (младшие) 32 байта IRAM (с адреса ***00 по 1Fh***) сгруппированы **в четыре банка по 8 регистров общего назначения (РОН) с именами R0 – R7 в каждом**. **Выбор рабочего (текущего) банка регистров осуществляется программно с помощью управляемых бит RS0 и RS1 слова состояния PSW** (табл. 3). Отличительной особенностью блока рабочих регистров является возможность использования, наряду с прямой и косвенной адресацией, прямой регистровой адресации. При старте МК рабочим является банк 0.

Следующие 16 байт IRAM (с адреса ***20h по 2Fh***) представляют собой область **128 прямо адресуемых бит (может быть использована для хранения 128 программно-управляемых пользовательских флагов)**. Обращение к каждому из указанных флагов может быть произведено двумя способами: **указанием прямого адреса бита (например, 7Ch)** или **указанием номера бита в байте (например, 2Fh.4)**. Каждый из 16 байт этой области допускает прямую и косвенную побайтовую адресацию.

![Структура младших 128 байт IRAM](image-14.png)

Оставшиеся 80 байт из области младших 128 байт IRAM и вся область старших 128 байт IRAM адресуется побайтно

### Регистры специального назначения

Блок регистров специального назначения (Special function register, SFR) содержит различное число регистров (в зависимости от модели МК). В качестве примера в табл. 2 приведены регистры SFR микроконтроллера AT89C52. Большинство регистров, приведенных в табл. 2, есть у любого МК семейства MCS-51.

Регистры с адресами, кратными восьми, допускают побитную адресацию (отмечены * в табл. 2).

![Регистры специального назначения](image-15.png)

Блок SFR содержит две группы регистров: регистры ядра МК и регистры
периферийных устройств.

Все регистры ядра МК, за исключением программного счетчика PC и
четырех банков регистров общего назначения, представлены в области SFR. Это
регистры A (ACC), B и PSW блока АЛУ, а также регистры-указатели SP, DPTR.

Аккумулятор ACC предназначен для хранения операндов при выполнении
арифметических и логических операций. Допускается обозначение аккумулятора
как А.

Регистр B используется в качестве регистра-расширителя аккумулятора при
выполнении операций умножения и деления. При выполнении других операций
регистр В может использоваться как регистр общего назначения.

Информация о состоянии выполняемой программы содержится в регистре
PSW (табл. 3).

![Регистр PSW](image-16.png)

Флаг C устанавливается, если операция приводит к переносу из старшего
бита результата (переполнение разрядов) или заему в старший бит результата
(отрицательный результат). При отсутствии переноса и заема флаг C
сбрасывается.

Флаг AC устанавливается, если операция приводит к переносу из младшего
полубайта в старший (при сложении) или заему в младший полубайт из старшего
(при вычитании). При отсутствии межтетрадного переноса и заема флаг AC
сбрасывается.

Флаг OV устанавливается, если операция приводит к переносу в старший бит
результата, но не к переносу из старшего бита, или наоборот (при отсутствии
переноса в старший бит, но при наличии переноса из старшего бита). В
противном случае OV сбрасывается. Таким образом, флаг OV фиксирует
переполнение для чисел со знаком. Отрицательные числа представляются в МК
дополнительном коде, поэтому в знаковом представлении числа с нулевым
старшим битом (от 00h до 7Fh) считаются положительными, а числа с единичным
старшим битом (от 80h до FFh) – отрицательными. Флаг OV устанавливается,
например, если результат сложения двух положительных чисел превышает 7Fh,
или если результат вычитания из отрицательного числа получился меньше 80h.
Флаг P обновляется в каждом машинном цикле: устанавливается, если число
единиц в аккумуляторе нечетно, и сбрасывается, если число единиц в
аккумуляторе четно. Флаг программно недоступен: при записи в PSW флаг P не
изменяется.
Флаг F0 предназначен для свободного использования программистом.
Команды, приводящие к изменению флагов С, AC и OV, приведены в разделе
1.4 (табл. 7).
Указатель стека SP (Stack pointer) может адресовать любую область IRAM.
Глубина стека не может превышать 256 байт. При загрузке данных в стек сначала
осуществляется инкремент SP, а затем выполняется запись в стек. При чтении
данные извлекаются из стека, а затем производится декремент SP.
С помощью 16-разрядного указателя данных DPTR (Data pointer)
обеспечивается косвенная адресация операндов при обращении к внешней памяти
данных и программ.

### Подключение внешней памяти программ и данных

В микроконтроллерах семейства MCS-51 имеется возможность подключения
внешней памяти программ (EROM) и данных (ERAM) объемом до 64 Кбайт
каждая. Механизм обращения МК к внешней памяти предусматривает
подключение микросхем памяти к выводам портов Р0 и Р2 и P3 с использованием
внешнего регистра. Схема одновременного подключения 64 Кбайт внешней
памяти программ и данных изображена на рис. 5.
При доступе к внешней памяти программ и данных 16-разрядный адрес
формируется на выводах порта P0 (младший байт) и порта P2 (старший байт).
Выдаваемый через порт Р0 младший байт адреса фиксируется во внешнем
регистре R по спаду сигнала ALE (Address Latch Enable), после чего линии порта
Р0 используются как шина данных.
Доступ к внешней памяти программ разрешен либо если присутствует
низкий уровень напряжения на входеEA , либо, если содержимое счетчика
команд PC превышает значение максимального адреса внутренней памяти.
Чтение из внешней памяти программ происходит по спаду сигнала на выводеPSEN
(Program Store ENable), выполняющего функцию разрешающего сигнала
чтения EROM.

![Подключение внешней памяти программ и данных](image-17.png)

Чтение внешней памяти данных происходит по спаду сигнала на выводе $\bar{RD}$ ,
а запись – по спаду сигнала на выводе $\bar{WR}$.

## Система команд

Система команд микроконтроллеров семейства MCS-51 состоит из 111 команд, выполняющих 54 операции (табл. 6). Операции производятся над данными четырех типов: битами, тетрадами (4-битными словами), байтами и 16-битными словами, при этом большинство операндов являются байтами.

Машинные коды команд представляются одним, двумя или тремя байтами. Команды выполняются за один или два машинных цикла. Исключение составляют команды умножения и деления, длительность исполнения которых равна 4 машинным циклам.

### Способы адресации

Для доступа к операндам используются **пять способов адресации** (табл. 4). Указанные способы адресации обеспечивают обращение к операндам-источникам. При обращении к операндам-приемникам непосредственная и базово-индексная адресации не используются.

![Способы адресации](image-8.png)

Регистровая адресация применяется для адресации регистров A, B, DPTR, флага С, также восьми регистров R0 – R7 текущего (рабочего) банка регистров. Номер регистра содержится в байте кода операции.

Прямая адресация, т.е. адресация с указанием 8-битного адреса операнда во втором или третьем байте команды, используется при обращении к младшим 128 байтам IRAM, регистрам блока SFR и прямо адресуемым битам. К последним относятся 128 бит из битовой области IRAM (рис. 4), а также биты регистров SFR, отмеченных * в табл. 2.

Операндом команды с непосредственной адресацией является константа, расположенная во втором или втором и третьем байтах команды.

При косвенной адресации происходит обращение к ячейке памяти, адрес которой содержится в регистре R0, R1 или DPTR. С использованием регистров R0 и R1 возможно организовать доступ к 256 байтам IRAM, а также к 256 байтам ERAM. Доступ в пределах 64 Кбайт может быть организован с помощью регистра DPTR. Для адресации старших 128 байт IRAM допустима только косвенная адресация. Отметим, что косвенная адресация через регистр SP используется в командах, производящих операции со стеком.

Для чтения памяти программ используется базово-индексная адресация, обеспечивающая формирование адреса выбираемого байта путем сложения 8-битного содержимого аккумулятора (исполняющего роль индексного регистра) с 16-битным содержимым DPTR или PC (исполняющего роль базового регистра). Такой способ адресации удобно применять для обращения к элементам массива данных, расположенного в памяти программ (пример использования приведен в описании работы с дисплеем).

Для обозначения типов данных и способов адресации в мнемониках команд применяются следующие обозначения

![Обозначения команд](image-9.png)

### Виды команд

Множество команд микроконтроллера может быть разделено на 4 группы:

1) команды передачи данных,  
2) команды арифметических операций;  
3) команды логических операций;  
4) команды управления переходами.  

### Команды передачи данных

Команды этой группы делятся на три класса: команды общего назначения, команды аккумулятора и команды DPTR.

#### Общего назначения

**MOV** выполняет пересылку байта или бита из операнда-источника в операнд-
приемник.  
**PUSH** инкрементирует (увеличивает на 1) регистр SP, а затем выполняет
пересылку байта-источника по адресу, содержащемуся в SP.  
**POP** выполняет пересылку байта, расположенного по адресу, содержащемуся
в SP, в операнд-приемник, а затем декрементирует (уменьшает на 1) регистр SP.

#### Команды пересылки аккумулятора

**XCHG** осуществляет обмен байта-источника с аккумулятором A.

**XCHD** осуществляет обмен младшего полубайта (с 0 по 3 биты) байта-источника с младшим полубайтом аккумулятора A.

**MOVX** выполняет передачу байта между ячейкой внешней памяти данных (ERAM) и аккумулятором. Адрес ячейки задается в регистре DPTR (16-битный адрес) или в регистре R0 или R1 (8-битный адрес).

**MOVС** выполняет передачу байта из памяти программ (ROM) в аккумулятор. Адрес ячейки задается в регистре DPTR (16-битный адрес) или в регистре R0 или R1 (8-битный адрес). Содержимое A до передачи используется в качестве индекса в 256-байтном массиве, адрес начала которого содержится в базовом регистре (DPTR или PC).

#### Команды пересылки DPTR

**MOV DPTR, #data16** загружает 16-битную константу в регистр DPTR (представлен в области SFR в виде регистровой пары: DPH и DPL).

### Команды арифметических операций

Микроконтроллер выполняет четыре арифметических операции. Операции выполняются над восьмибитными беззнаковыми числами, однако флаг переполнения (см. раздел 1.3.2) позволяет использовать операции сложения и вычитания как для беззнаковых операндов, так и для операндов со знаком. Арифметические операции также могут напрямую производиться с числами в коде BCD.

#### Сложение

**INC** (инкремент) прибавляет единицу к операнду-источнику и помещает
результат в операнд.

**ADD** прибавляет аккумулятор к операнду-источнику и возвращает результат
в аккумулятор.

**ADDС** прибавляет аккумулятор к операнду-источнику, затем прибавляет 1,
если флаг C был установлен, и возвращает результат в аккумулятор.

**DA** используется для коррекции результата после операции сложения двух
чисел в коде BCD (двоично-десятичный код – каждый разряд десятичного числа
представляется четырьмя битами, например $96_{10} = 1001 0110_{BCD}$). Результат
коррекции записывается в аккумулятор. Флаг C устанавливается, если результат
превышает $99_{10}$, иначе C сбрасывается.

#### Вычитание

**SUBB** вычитает из аккумулятора операнд-источник, затем вычитает 1, если
флаг C был установлен, и возвращает результат в аккумулятор. Операция
вычитания производится путем сложения уменьшаемого с дополнительным
кодом вычитаемого.

**DEC** (декремент) вычитает единицу из операнда-источника и помещает
результат в операнд.

#### Умножение

**MUL** выполняет умножение аккумулятора А на регистр B. Сомножители интерпретируются как восьмибитные беззнаковые числа. Результат умножения занимает два байта: младший байт помещается в аккумулятор, старший – в регистр B. Флаг С сбрасывается. Флаг OV устанавливается, если старший байт результата не нулевой, в противном случае OV сбрасывается.

#### Деление

**DIV** выполняет деление аккумулятора А на регистр B. Операнды интерпретируются как восьмибитные беззнаковые числа. Целая часть частного помещается в аккумулятор, остаток – в регистр B. Флаг С сбрасывается. Флаг OV устанавливается в случае деления на ноль, в противном случае OV сбрасывается.

### Логические операции

#### Унарные

**CLR** обнуляет операнд. Операндом может быть аккумулятор или любой прямо адресуемый бит.

**SETB** записывает 1 в операнд. Операндом может быть любой прямо адресуемый бит.

**CPL** инвертирует операнд.

**RL, RLC, RR, RRC и SWAP** – пять сдвиговых операций, которые могут быть
применены только к аккумулятору

RL RR - влево вправо **циклически**

RLC RRC - влево вправо **циклически с использованием C**

SWAP меняет местами старший и младший полубайты

#### Бинарные

**ANL** Побитовое И, результат в первый операнд

**ORL** Побитовое ИЛИ

**XRL** XOR

### Команды управления

К командам этой группы относятся **команды безусловных переходов**,
**условных переходов** и **возврата из прерываний**.

#### Безусловные переходы

**ACALL** - двухбайтная команда **вызова подпрограммы**, используется, если адрес подпрограммы расположен в пределах текущей 2Кбайтной страницы памяти программ. ACALL помещает в стек двухбайтный адрес следующей за ней в памяти программ команды (т.е. содержимое PC, адрес возврата), а затем заменяет в программном счетчике PC 11 младших бит на 11-битное значение адреса, указанное в операнде. Таким образом, если команда ACALL занимает два последних байта на 2Кбайтной странице, переход будет осуществлен на следующую страницу памяти программ.

**LCALL** – трехбайтная команда **вызова подпрограммы**, используется для адресации всего 64Кбайтного адресного пространства памяти программ. LCALL помещает в стек адрес следующей за ней в памяти программ команды (т.е. содержимое PC, адрес возврата), а затем помещает в программный счетчик PC 16-битное значение адреса подпрограммы, указанное в операнде

**RET** (возврат из подпрограммы) извлекает из стека два байта (адрес возврата, помещенный в стек предшествующей операцией CALL) и помещает их в PC. При этом значение SP уменьшается на 2

**AJMP** – двухбайтная команда **безусловного перехода**, используется, если адрес перехода расположен в пределах текущей 2Кбайтной страницы памяти программ. AJMP заменяет в программном счетчике PC (содержащем адрес следующей за AJMP команды) 11 младших бит на 11-битное значение адреса, указанное в операнде.

**LJMP** – трехбайтная команда безусловного перехода, используется для адресации всего 64Кбайтного адресного пространства памяти программ. LJMP помещает в программный счетчик PC 16-битное значение адреса, указанное в операнде.

**SJMP** – двухбайтная команда **короткого безусловного перехода**, используется, если адрес перехода расположен на расстоянии от -128 до 127 байт от следующей за SJMP команды. SJMP прибавляет к программному счетчику PC (содержащему адрес следующей за SJMP команды) значение смещения (интерпретируется как число со знаком), указанное в операнде.

**JMP @A+DPTR** – однобайтная команда безусловного перехода, используется
для адресации всего 64Кбайтного адресного пространства памяти программ. JMP
помещает в программный счетчик PC 16-битную сумму аккумулятора
(интерпретируется как беззнакове число) и регистра DPTR

#### Команды условных переходов

Эта группа команд осуществляет короткий переход только при выполнении определенных условий. Адрес перехода должен быть расположен на расстоянии от -128 до 127 байт от следующей команды. При выполнении соответствующего условия к программному счетчику PC (содержащему адрес следующей команды) прибавляется значение смещения (интерпретируется как число со знаком), указанное в операнде.

**JZ** осуществляет переход, если аккумулятор равен нулю.  
**JNZ** осуществляет переход, если аккумулятор не равен нулю.  
**JC** осуществляет переход, если флаг С равен единице.  
**JNC** осуществляет переход, если флаг С равен нулю.  
**JB** осуществляет переход, если бит-операнд равен единице.  
**JNB** осуществляет переход, если бит-операнд равен нулю.  
**JBC** осуществляет переход, если бит-операнд равен единице и записывает ноль в этот бит.  
**CJNE** сравнивает первый и второй операнды и выполняет переход, если операнды не равны. Флаг C устанавливается, если первый операнд меньше второго. В противном случае флаг C сбрасывается.  
**DJNZ** уменьшает на 1 (декрементирует) операнд-источник и возвращает результат в операнд. Переход осуществляется, если результат не равен нулю.  

#### Команда возврата из прерывания

**RETI** извлекает из стека два байта (адрес возврата, помещенный в стек при переходе по вектору прерывания) и помещает их в PC. При этом значение SP уменьшается на 2. Разрешает прерывания с текущим уровнем приоритета.

### Список команд

Полный перечень команд микроконтроллера приведен в табл. 6. В столбце Б указано количество байт, занимаемых командой в памяти программ. В столбце Ц приведено количество машинных циклов, необходимых для выполнения команды.

![Перечень команд](image.png)

![Перечень команд продолжение](image-1.png)

![Перечень команд продолжение](image-2.png)

![Перечень команд продолжение](image-3.png)

![Перечень команд продолжение](image-4.png)

![Конец](image-5.png)

![Команды изменяющие флаги в регистре PSW](image-6.png)

## Программирование 

![Шаблоны строк файлов](image-7.png)

Квадратными скобками обозначены необязательные части строки

Файл рекомендуется оформлять согласно следующему шаблону:

```asm
;*******************************************************************
; *
; Filename: *
; Date: *
; File Version: *
; Author: *
; Company: *
; Description: *
; *
;*******************************************************************
; Variables
;*******************************************************************
; TODO PLACE VARIABLE DEFINITIONS HERE
;*******************************************************************
; Reset Vector
;*******************************************************************
org 0h ; processor reset vector
ajmp start ; go to beginning of program
;*******************************************************************
; Interrupt Service Routines
;*******************************************************************
; TODO INSERT ISR HERE
;*******************************************************************
; MAIN PROGRAM
;*******************************************************************
org ; let linker place main program
START:
; Insert Your Program Here
sjmp $ ; loop forever
END
```

В тексте программы кроме команд на языке ассемблера используются так называемые директивы компилятора – инструкции компилятору. Директивы позволяют указать адрес размещения кода в памяти программ, задать символьные имена переменных, подключить к проекту дополнительные файлы, использовать конструкции языков высокого уровня при написании программ.

Для задания символьных имен констант используют директиву equ,
например:  
`x equ 18h`

Тогда команда логического умножения бита С на бит с адресом 23h может
быть записана следующим образом.  
`anl c,/x`

Для того чтобы задать адрес размещения кода в памяти программ, используют директивы org и code. Для того чтобы программа начала выполняться при запуске МК, необходимо разместить код, начиная с адреса 00h (адрес вектора сброса (Reset Vector)). При этом, так как блок памяти программ с адресами 03h – 93h содержит векторы прерываний, обычно основной код программы размещают с адреса, большего 93h, а по адресу вектора сброса располагают команду перехода, например:

```asm
org 0h ; processor reset vector
33
ajmp start ; go to beginning of program
…
org 100h
start:
```

Основная программа будет размещена по адресу 100h

Между вектором сброса и основной программой при необходимости по
адресам векторов прерываний (Interrupt Vector) размещают подпрограммы
обслуживания соответствующих прерываний, каждая из которых должна
завершаться командой RETI.
Для размещения байтов данных в памяти программ использую директиву
db. Например, после компиляции программы, содержащей строки, приведенные
ниже, в памяти программ, начиная с адреса 200h будет записано 8 байт:
десятичное число 31, 6 байт, содержащих ASCII-коды символов слова и
десятичное число 20.


```asm
org 200h
DB 31,'August',20
```

### Форматы данных

```asm

db 'string' ; String
mov a,#100111b ; двоичное число
mov a,#47q ; восьмиричное число
mov a,#39d ; десятичное число
mov a,#39 ; десятичное число
mov a,#27h ; шестнадцатеричное число
mov a,#'9' ; Character

```

### Примеры программ

Написать программу, размещающую массив FFh…F0h во внутренней памяти данных(IRAM), начиная с адреса 50h.

```asm

;*******************************************************************
; *
; Filename: ex11.asm *
; Date: 2020/02/07 *
; File Version: 1 *
; Author: Solov’eva T. N. *
; Company: SUAI *
; Description: example 1.1 *
; *
;*******************************************************************
; Reset Vector
;*******************************************************************
org 0h ; processor reset vector
ajmp start ; go to beginning of program
;*******************************************************************
; MAIN PROGRAM
;*******************************************************************
org 100h
start:
mov R0,#050h ; нач. адрес -> R0
mov A,#0FFh ; нач. значение -> А
m1: mov @R0,A
inc R0
dec A
cjne A,#0EFh,m1
sjmp $ ; loop forever
END

```

Программа вычисления логического
выражения $F = \bar{x}y \oplus \bar{r}$, где x, y, r – биты.

Сначала назначим расположение операндов в памяти. Пусть операнды x, y, r
и бит промежуточного результата (обозначим его buf) находятся в младших
разрядах ячейки с адресом 23h (рис. 4 и 7), а бит значения результата (обозначим
его rez) – в старшем разряде ячейки с адресом 2Dh. При написании программы
вместо адресов операндов удобно использовать символьные имена. Для этого
применяется директива компилятора equ.

![Расположение операндов в памяти](image-18.png)

Необходимо учесть, что в битовых командах МК нет операции сложения по
модулю два, поэтому исходное выражение придется видоизменить:

$F=\bar{x}yr \lor \bar{\bar{x}y}\bar{r}$

Результат:

```asm
;*******************************************************************
; *
; Filename: ex12.asm *
; Date: 2020/02/07 *
; File Version: 0 *
; Author: Solov’eva T. N. *
; Company: SUAI *
; Description: example 1.2 *
; *
;*******************************************************************
x equ 18h
y equ 19h
r equ 1ah
buf equ 1bh
rez equ 6fh;
;*******************************************************************
; Reset Vector
;*******************************************************************
RES_VECT CODE 0x0000 ; processor reset vector
SJMP START ; go to beginning of program
;*******************************************************************
; MAIN PROGRAM
;*******************************************************************
MAIN_PROG CODE 0x0100
START:
mov c,y ;у -> c
anl c,/x ;/x*у -> c
anl c,r ;/x*у*r -> c
mov buf,c ;/x*у*r -> buf
mov c,y ;у -> c
anl c,/x ;/x*у -> c
cpl c ;/(/x*у) -> c
anl c,/r ;/(/x*у)*/r -> c
orl c,buf ;F -> c
mov rez,c ;F -> rez
SJMP $ ; loop forever
END
```

# Организация взаимодействия микроконтроллера с внешними устройствами

Большинство микроконтроллеров семейства MCS-51 содержат в своем составе четыре двунаправленных восьмиразрядных параллельных портов ввода-вывода P0 – P3, а также двунаправленный последовательный порт.

Каждый внешний вывод порта связан с триггером. Отдельные триггеры разрядов портов объединены в регистры с именами одноименных портов Р0 – Р3. Указанные регистры размещаются в блоке SFR

![Адреса портов](image-19.png)

При использовании вывода порта для передачи информации на выводе отображается содержимое триггера (то есть, **что запишем в разряд регистра порта, то и будет на выводе**). **Для организации ввода информации триггер должен быть установлен в 1.**

К регистрам Р0 – Р3 возможно обращение только при использовании прямой адресации, при этом ко всем отдельным разрядам портов допускается побитовое обращение.

## Индикатор

В качестве устройства вывода используется семисегментный индикатор

![семисегментный индикатор](image-20.png)

![Схема подключения индикатора](image-21.png)

При необходимости использования нескольких индикаторов с целью экономии числа линий связи выводы сегментов индикаторов объединяются (рис.4). В этом случае для отображения информации на индикаторах используют принцип динамической индикации, основанный на инерции человеческого зрения. Применение этого принципа заключается в **поочередном включении индикаторов**, при этом частота включения должна быть более 30 Гц. В этом случае **человек увидит все индикаторы включенными одновременно**.

Включение и выключение каждого индикатора производится путем подачи соответствующего уровня напряжения на его общий вывод. В связи с этим, в отличие от использования одноразрядного индикатора, при использовании многоразрядных индикаторных панелей общий вывод каждого индикатора соединяется с микроконтроллером (рис. 4).

![Подключение мнгоразрядного индикатора](image-22.png)

## Матрица

Более широкие возможности  представляет  светодиодная  матрица  –  набор  светодиодов, расположенных в виде матрицы (рис. 5). При этом светодиоды, находящие в 49 одной строке, имеют общий катод, а светодиоды, находящиеся в одном столбце – общий анод.

![Светодиодная матрица](image-23.png)

Так как предельное допустимое значение входного тока на выводе
микроконтроллера составляет 10 мА и это значение меньше, чем суммарный ток,
который может получиться на общем проводе столбца при одновременной
активации всех его светодиодов, для каждого столбца в схеме использован
транзисторный ключ.
Диоды в столбцах матрицы объединены катодами, следовательно, для
активации столбца необходимо подать 1 на соответствующий разряд порта P3,
чтобы открыть транзисторный ключ.

![Подключение матрицы к мк](image-24.png)

### Пример вывода смайлика

Для управления строками матрицы будем использовать порт P1, а для
управления столбцами – порт P3

```asm

;*******************************************************************
; *
; Filename: LEDMatrix.asm
; Date: 2021/05/12
; File Version: 1
; Author: Solov'eva T.N.
; Company: SUAI
; Description:
; *
;*******************************************************************
; Reset Vector
;*******************************************************************
org
 0h
 ; processor reset vector
ajmp
 start
 ; go to beginning of program
;*******************************************************************
; MAIN PROGRAM
;*******************************************************************
org
 100h
start:
mov P3,#0
loop:
mov P1,#0
 ;очищаем
mov P3,#01000010b
 ;второй и предпоследний столбец
mov P1,#00000100b
lcall delay
mov P1,#0
mov P3,#00100100b
 ;третий и шестой столбец
mov P1,#00100010b
lcall delay
mov P1,#0
mov P3,#00011000b
 ;два средних столбца
mov P1,#00000010b
lcall delay
sjmp loop
delay:
nop
nop
nop
nop
nop
nop
ret
;подпрограмма задержки
finish: sjmp $ ;конец программы
end 
```

![Результат выполнения программы](image-25.png)

Предварительно в симуляторе необходимо настроить матрицу (Light up when: Row 1 & Column 1).

Следует отметить, что в программе реализована задержка на 10 мкс. В
реальных системах эта задержка может быть сделана больше (например, 10 мс).

# Использование ЖКИ

Многие  современные  ЖКИ,  предназначенные  для  подключения  к параллельным портам ввода-вывода МК, построены на основе контроллера HD44780 фирмы Hitachi или его аналогах. Такие дисплеи имеют от 1 до 4 строк и от 8 символов в строке.

## Устройство и система команд дисплея на базе HD44780

ЖКИ на базе HD44780 содержит видеопамять (Display Data RAM, DDRAM), в которой хранятся ASCII-коды отображаемых символов, а также обладает собственной системой команд для управления жидкокристаллической панелью. Помимо стандартных символов имеется возможность создания символов пользователем в памяти CGRAM (Character Generator RAM).

ЖКИ имеет восьмиразрядную шину команд-данных, которая на рис. 1 подключена к порту Р2, и шину управления, в состав которой входят одноразрядные линии: разрешения программирования (E), выбора типа посылки (RS) и выбора направления передачи (RW). Эти линии на рис. 1 подключены к трем старшим разрядам порта Р1 (Р1.7, Р1.5 и Р1.6 соответственно).

Прием или выдача информации на входах ЖКИ происходит по спаду сигнала на входе E. При RW = 0 происходит чтение информации на шине DB, при RW = 1 58 – выдача информации из ЖКИ на шину DB. При RS = 0 информация на шине DB интерпретируется как команда, при RS = 1 – как данные.

![Подключение клавиатуры и ЖКИ к МК](image-26.png)

Ниже приведены назначение значения отдельных битов команд.  
I/D = 0 декремент AC при записи, I/D = 1 инкремент AC при записи.  
S = 1 сдвиг окна дисплея при записи нового символа в DDRAM.  
D = 1 включить дисплей.  
С = 1 включить курсор.  
B = 1 курсор в виде мигающего черного квадрата.  
S/C = 0 сдвиг курсора на 1 позицию, S/C = 1 сдвиг окна на 1 позицию.  
R/L – направление сдвига курсора и окна (0 влево, 1 вправо).  
D/L = 1 шина данных 8 бит, D/L = 0 шина данных 4 бита.  
N = 0 одна строка, N = 1 две строки.  
F = 0 размер символа 5х8 точек, F = 1 размер символа 5х10 точек.  
AG – адрес в памяти CGRAM.  
АD – адрес в памяти DDRAM.  
BF – флаг занятости.  
AC – адрес, хранящийся в указателе адреса ЖКИ.  
DT – данные.  

После перезагрузки ЖКИ управляющие биты имеют следующие значения:  
I/D = 1;  
D =0;  
D/L = 1;  
S = 0;  
С = 0;  
N = 0;  
B = 0;  
F = 0.  

![Система команд ЖКИ](image-27.png)

Перед выполнением команд обращения к памяти ЖКИ (последние 2 команды в табл) необходимо выполнить команду установки адреса (7 или 8 строка в табл). Если подряд выполняются несколько команд обращения к памяти, то достаточно установить адрес один раз – перед первой командой обращения – далее адрес будет автоматически изменяться в соответствии со значением бита I/D.

**Во время выполнения дисплеем команды флаг BF устанавливается. по окончании выполнения команды происходит сброс этого флага.**

Последний столбец табл. содержит информацию о времени выполнения каждой команды. При выполнении команды все обращения дисплей игнорирует, поэтому в программе работы с дисплеем **следует предусмотреть задержки между обращениями к ЖКИ**. **Большинство команд выполняются за 40 мкс**. Исключение составляют команда чтения BF-AC, выполняемая в течение 1 мкс, а также команды очистки дисплея и очистки сдвигов (первые 2 строки в табл), время выполнения которых зависит от каждого конкретного случая. При использовании команд очистки рекомендуется проверять флаг BF для контроля завершения команды.

## Пример программы вывода строк на жки

Рассмотрим пример вывода на ЖКИ размером 2 х 20 символов, подключенный к МК семейства MCS-51 (рис. 1), двух строк: «it is test example.» и «0123456789ABCDFI@#$».

Выводимая строка символов записана с помощью директивы компилятора db в виде последовательности кодов символов в памяти программ микроконтроллера, начиная с адреса 0FD0h (см. конец программы).

![Схема алгоритма вывода строк](image-28.png)

```asm

;*******************************************************************
; *
; Filename: ex3.asm
; Date: 2020/05/12
; File Version: 1
; Author: Solov'eva T.N.
; Company: SUAI
; Description: example 3
; *
;*******************************************************************
; Variables
;*******************************************************************
switch equ 43h ;переключатель «команда-данные» (RS)
bte equ 44h ;выдаваемый на ЖКИ байт
;*******************************************************************
; Reset Vector
;*******************************************************************
org 0h ; processor reset vector
  ajmp start ; go to beginning of program
;*******************************************************************
; MAIN PROGRAM
;*******************************************************************
org 100h
start: 
  
indic_init: ;инициализация ЖКИ
  mov switch, #0; переключатель уст-ть на команду (RS=0)
  mov bte, #38h ;байт – команда
  lcall indic_wr ;вызов подпрограммы передачи в ЖКИ
  mov bte, #0ch ;активация всех знакомест
  lcall indic_wr
  mov bte, #06h ;режим автом. перемещения курсора
  lcall indic_wr
  mov bte, #80h ;установка адреса первого символа
  lcall indic_wr

  ;вывод строк
  mov switch, #1 ;переключатель – данные (RS=1)
  mov dptr, #0fd0h ;адрес, по которому расположены данные
                   ;(см. конец программы)

indic_data_wr1: ;вывод символов первой строки
  clr a
  movc a, @a+dptr

ind_row1:
  mov bte, a ;передаваемый байт – код символа
  lcall indic_wr
  inc dptr
  mov a, dpl ;младший байт указателя данных
  cjne a, #0E3h, indic_data_wr1 ;пока не введены 19 символов 1ой строки
  
  mov switch, #0 ;RS=0 – команда
  mov bte, #0C0h ;установка адреса первого символа второй строки
  lcall indic_wr
  mov switch, #1 ;RS=1 - данные

indic_data_wr2: ;вывод символов второй строки
  clr a
  movc a, @a+dptr

ind_row2: 
  mov bte, a
  lcall indic_wr
  inc dptr
  mov a, dpl
  cjne a, #0F6h, indic_data_wr2
  ;E3h+13h=F6h – адр. конца второй стр.
  jmp finish
  ;переход на конец программы
  

indic_wr: ;подпрограмма передачи в ЖКИ
  mov p2, bte ;передаваемый байт – в Р2
  setb p1.7   ;E:=1
  clr p1.6    ;RW:=0 (запись)

  mov a, switch
  mov c, acc.0 ;нам нужен 0-ой бит аккумулятора
  mov p1.5, c ;RS:=switch (команда/данные)

  lcall indic_delay ;вызов подпрограммы задержки

  clr p1.7 ;E:=0

  lcall indic_delay

  setb p1.7 ;E:=1
  ret 

indic_delay: ;подпрограмма задержки на 40мкс
  push A ;сохраняем аккумулятор в стеке
  mov A, #0Ah ; 40 = 2+2+1+А(1+2)+1+2+2
  m: 
    dec A
  jnz m
  nop
  pop A ;восстанавливаем значение аккумулятора
  ret

org 0FD0h ;данные располагаем в памяти программ
data:
  db 'it is test example.' ;директива db помещает коды
  db '0123456789ABCDFI@#$' ;символов в последовательные ячейки памяти программ
finish: sjmp $ ;конец программы
end

```

Подпрограмма indic_delay осуществляет задержку на 40 мкс следующим образом. Команды lcall, push, jnz, pop и ret выполняются в течение двух машинных циклов, команды mov, dec и nop – в течение одного (см. табл. 6 в работе 1), поэтому время выполнения подпрограммы indic_delay без учета nop составляет 2 + 2 + 1 + A∙(1 + 2) + 2 + 2 = 9 + 3A машинных цикла, то есть зависит от содержимого A. При тактовой частоте 12 МГц один машинный цикл выполняется за 1 мкс, поэтому для того, чтобы подпрограмма indic_delay осуществляла задержку на 40 мкс можно становить значение A = 10 = 0Ah и добавить одну команду nop после цикла.
