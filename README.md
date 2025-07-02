# Verilog
This repository contains a collection of small Verilog modules and mini-projects, created for practice and educational purposes. Each project is implemented in a modular and understandable format, suitable for beginners and intermediate learners of digital design using Verilog.
Project structure: 
1. ripple4bit_adder

**Description**: Implements a 4 bit ripple carry adder.
**Purpose**: Demonstrates a basic combinational circuit design using structural modeling.

2. singleclockfifo

**Description**: Implements a single clock (synchronous fifo).
**Purpose**: Shows how to design a synchronous FIFO where both read and write instructions are driven by the same clock.

3. 32bitadder

**Description**: Implements a 32 bit adder.
**Purpose**: Extends the idea of simple adders to wider word lengths.

4. array_mul4bit

**Description**: Implements a 4 bit Array Multiplier.
**Purpose**: Introduces basic multiplication in hardware using array logic.

5. vedic4bit

**Description**: Implements a 4 bit array multiplier using the vedic multiplication method.
**Purpose**: Introduces advanced methods like vedic method to multiply, easier since it's reuses modules made before.

6. barrelshifter8bit

**Description**: Implements a 8 bit barrel shifter using 2x1 mux.
**Purpose**: It has both shift left and shift right modules, helps understand concepts of mux better.

7. C_LookAhead

**Description**: The Carry Look-Ahead Adder is a fast adder architecture designed to improve the speed of binary addition by reducing the propagation delay of carry signals. Instead of waiting for the carry to propagate bit-by-bit, the CLA generates carry signals in advance using generate and propagate logic for each bit position.
**Purpose**: The main purpose of the CLA is to accelerate addition operations in digital circuits by minimizing carry propagation time. It is especially useful in high-performance processors and systems where fast arithmetic computation is critical.

8. carryselectadder

**Description**: The Carry Select Adder is a compromise between speed and complexity. It partitions the addition operation into smaller blocks and performs parallel computations assuming both possible carry-in values (0 and 1). The correct result is selected using a multiplexer once the actual carry-in is known.
**Purpose**: The CSA aims to improve addition speed by allowing partial parallel computation and reducing the waiting time caused by carry propagation.

9. CarrySaveAdder

**Description**: A Carry-Save Adder adds three or more binary numbers at once by saving carries instead of immediately propagating them. It outputs two vectors: partial sum and carry.
**Purpose**: Used to speed up multi-operand addition in operations like multiplication or accumulation, where full carry propagation can be delayed until the final step.

10. CarrySkipAdder

**Description**:  Carry Skip Adder divides the adder into blocks and allows the carry to bypass (or "skip") an entire block if all bits in that block propagate the carry. Each block uses ripple carry internally with added skip logic.
**Purpose**: Improves speed over ripple carry adders by reducing carry propagation delay through blocks, especially in wider adders.

11. Shift_AddMultiplier

**Description**: The Shift-and-Add Multiplier is a sequential digital circuit that multiplies two unsigned binary numbers by repeatedly shifting and conditionally adding the multiplicand to an accumulator based on the bits of the multiplier.
**Purpose**: To perform binary multiplication efficiently using simple operations (shifts and adds), making it suitable for hardware implementations where area and control logic need to be minimized.

12. BoothMultiplier

**Description**: A digital circuit that multiplies signed binary numbers using Booth’s algorithm to reduce operations and improve efficiency.
**Purpose**: To perform fast, efficient signed multiplication in two's complement form.

13. BCDAdder

**Description**: A BCD adder adds two decimal digits in binary-coded decimal form. It ensures correct decimal results by adjusting sums over 9
**Purpose**: Used in devices like calculators and digital displays.


Contributions are welcome! If you'd like to add more mini-projects or enhance the existing ones, feel free to open a pull request or issue.