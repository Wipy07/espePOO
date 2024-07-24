.model small

.stack 64
.data

; Declarando variables globales
numero1 db 0
numero2 db 0

suma db 0
resta db 0
multiplicacion db 0
division db 0

msjn1 db 10,13, "ESPE TAREA COMPUTACION DIGITAL - CALCULADORA BASICA", 10,13, 10,13, "                 Actividad de aprendizaje N.o 1-SP", 10,13, "             Lenguaje ensamblador", 10,13, 10,13, "Ingrese el primer numero= ",'$'
msjn2 db 10,13, "Ingrese el segundo numero= ",'$'
msjnError db 10,13, "Error: Los numeros a ingresar deben ser de un digito. Intente nuevamente.", 10,13, '$'

; Mensaje para mostrar los resultados
msjnS db 10,13, "La suma es= ",'$', 10,13
msjnR db 10,13, "La resta= ",'$', 10,13
msjnM db 10,13, "La Multiplicacion es= ",'$', 10,13
msjnD db 10,13, "La division es = ",'$', 10,13
msjnMenu db 10,13, 10,13, "1. Calcular nuevamente", 10,13, "2. Salir", 10,13, "Ingrese una opción: ", 10,13, '$'

.code
begin proc far

    ; Direccionamiento del procedimiento
    mov ax, @data
    mov ds, ax

mainLoop:
    ; Solicitar del teclado numero 1
    mov ah, 09
    lea dx, msjn1
    int 21h
    mov ah, 01
    int 21h
    sub al, 30h

    ; Verificar si el número ingresado es de un solo dígito
    cmp al, 9
    ja errorInput
    mov numero1, al

    ; Solicitar del teclado numero 2
    mov ah, 09
    lea dx, msjn2
    int 21h
    mov ah, 01
    int 21h
    sub al, 30h

    ; Verificar si el número ingresado es de un solo dígito
    cmp al, 9
    ja errorInput
    mov numero2, al

    ; Operaciones aritmeticas
    ; SUMA
    mov al, numero1
    add al, numero2
    mov suma, al

    ; RESTA
    mov al, numero1
    sub al, numero2
    mov resta, al

    ; MULTIPLICACION
    mov al, numero1
    mul numero2
    mov multiplicacion, al

    ; DIVISION
    mov al, numero1
    div numero2
    mov division, al

    ; Mostrar los mensajes de los resultados
    ; Mostrando la suma
    mov ah, 09
    lea dx, msjnS
    int 21h
    mov dl, suma
    add dl, 30h
    mov ah, 02
    int 21h

    ; Mostrando la resta
    mov ah, 09
    lea dx, msjnR
    int 21h
    mov dl, resta
    add dl, 30h
    mov ah, 02
    int 21h

    ; Mostrando la multiplicacion
    mov ah, 09
    lea dx, msjnM
    int 21h
    mov dl, multiplicacion
    add dl, 30h
    mov ah, 02
    int 21h

    ; Mostrando la division
    mov ah, 09
    lea dx, msjnD
    int 21h
    mov dl, division
    add dl, 30h
    mov ah, 02
    int 21h

    ; Mostrar menu para repetir o salir
    mov ah, 09
    lea dx, msjnMenu
    int 21h
    mov ah, 01
    int 21h
    sub al, 30h

    ; Verificar opción
    cmp al, 1
    je mainLoop
    cmp al, 2
    je exitProgram

errorInput:
    ; Mostrar mensaje de error y redirigir al menú principal
    mov ah, 09
    lea dx, msjnError
    int 21h
    jmp mainLoop

exitProgram:
    ; Cierre del programa
    mov ah, 4Ch
    int 21h

begin endp
end
