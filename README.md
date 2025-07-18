# VERILOG
This repository contains a collection of small Verilog modules and mini-projects, created for practice and educational purposes. Each project is implemented in a modular and understandable format, suitable for beginners and intermediate learners of digital design using Verilog.

## PROJECT OVERVIEW:

1. Reinforce Digital Design Concepts.
2. Develop and simulate real-world circuits.
3. Master VerilogHDL Fundamentals
4. Gain exposure to modern EDA tools.

## PROJECT STRUCTURE:

### 1. ripple4bit_adder

**Description**: Implements a 4 bit ripple carry adder.
**Purpose**: Demonstrates a basic combinational circuit design using structural modeling.

### 2. singleclockfifo

**Description**: Implements a single clock (synchronous fifo).
**Purpose**: Shows how to design a synchronous FIFO where both read and write instructions are driven by the same clock.

### 3. 32bitadder

**Description**: Implements a 32 bit adder.
**Purpose**: Extends the idea of simple adders to wider word lengths.

### 4. array_mul4bit

**Description**: Implements a 4 bit Array Multiplier.
**Purpose**: Introduces basic multiplication in hardware using array logic.

### 5. vedic4bit

**Description**: Implements a 4 bit array multiplier using the vedic multiplication method.
**Purpose**: Introduces advanced methods like vedic method to multiply, easier since it's reuses modules made before.

### 6. barrelshifter8bit

**Description**: Implements a 8 bit barrel shifter using 2x1 mux.
**Purpose**: It has both shift left and shift right modules, helps understand concepts of mux better.

### 7. C_LookAhead

**Description**: The Carry Look-Ahead Adder is a fast adder architecture designed to improve the speed of binary addition by reducing the propagation delay of carry signals. Instead of waiting for the carry to propagate bit-by-bit, the CLA generates carry signals in advance using generate and propagate logic for each bit position.
**Purpose**: The main purpose of the CLA is to accelerate addition operations in digital circuits by minimizing carry propagation time. It is especially useful in high-performance processors and systems where fast arithmetic computation is critical.

### 8. carryselectadder

**Description**: The Carry Select Adder is a compromise between speed and complexity. It partitions the addition operation into smaller blocks and performs parallel computations assuming both possible carry-in values (0 and 1). The correct result is selected using a multiplexer once the actual carry-in is known.
**Purpose**: The CSA aims to improve addition speed by allowing partial parallel computation and reducing the waiting time caused by carry propagation.

### 9. CarrySaveAdder

**Description**: A Carry-Save Adder adds three or more binary numbers at once by saving carries instead of immediately propagating them. It outputs two vectors: partial sum and carry.
**Purpose**: Used to speed up multi-operand addition in operations like multiplication or accumulation, where full carry propagation can be delayed until the final step.

### 10. CarrySkipAdder

**Description**:  Carry Skip Adder divides the adder into blocks and allows the carry to bypass (or "skip") an entire block if all bits in that block propagate the carry. Each block uses ripple carry internally with added skip logic.
**Purpose**: Improves speed over ripple carry adders by reducing carry propagation delay through blocks, especially in wider adders.

### 11. Shift_AddMultiplier

**Description**: The Shift-and-Add Multiplier is a sequential digital circuit that multiplies two unsigned binary numbers by repeatedly shifting and conditionally adding the multiplicand to an accumulator based on the bits of the multiplier.
**Purpose**: To perform binary multiplication efficiently using simple operations (shifts and adds), making it suitable for hardware implementations where area and control logic need to be minimized.

### 12. BoothMultiplier

**Description**: A digital circuit that multiplies signed binary numbers using Booth’s algorithm to reduce operations and improve efficiency.
**Purpose**: To perform fast, efficient signed multiplication in two's complement form.

### 13. BCDAdder

**Description**: A BCD adder adds two decimal digits in binary-coded decimal form. It ensures correct decimal results by adjusting sums over 9
**Purpose**: Used in devices like calculators and digital displays.

### 14. UniversalShiftRegister

**Description**: A 4-bit universal shift register that can hold, shift left/right, parallel load, or invert data based on a 3-bit control input
**Purpose**: It’s used for flexible data storage and manipulation in digital systems.

### 15. FSM

**Description**: Mealy and moore state machines to detect a sequence of 2 or more 1's has been implemented.
**Purpose**: FSMs are used to model and control sequential logic where the output depends on a sequence of inputs over time. 

### 16. ComplexMultiplication

**Description**: This Verilog module implements complex number multiplication. Each complex input is packed into a 16-bit value, where the upper 8 bits represent the real part and the lower 8 bits represent the imaginary part.
**Purpose**: The module performs the multiplication of two complex numbers of the form (a + jb) and (c + jd) using the formula: (a + jb) * (c + jd) = (ac - bd) + j(ad + bc)
The result is a 32-bit output where the upper 16 bits contain the real part and the lower 16 bits contain the imaginary part of the product.

### 17. Radix4Booth

**Description**: The Radix4Booth implements a radix4 modified booth algorithm for efficient signed multiplication of two 8 bit numbers. It processes 2 bit of the multiplier at a time reducing the number of partial products and improving performance. 
**Purpose**: The modified booth algorithm is faster in terms of time and performance. It makes it suitable for arithmetic units in DSP, CPU and FPGAs where high speed multiplication is needed.

### 18. SinglePortRam

**Description**: Single-Port RAM is a type of memory block that allows only one access (either read or write) at a time through a single address and data port. It uses a common clock to synchronize all operations.
**Purpose**: Single-Port RAM is used in digital systems to store temporary or permanent data, such as Buffering data in signal processing systems,Holding intermediate results in processors,Memory for lookup tables, configuration data, or control logic.

### 19. DualPortRam

**Description**: Dual Port RAM is a type of memory that has two independent access ports, allowing simultaneous read and/or write operations on two different addresses.
**Purpose**: Enables faster data access by allowing two different operations (read/write) to happen at the same time.

### 20. ROM

**Description**: ROM is a type of non-volatile memory used in computers and electronic devices to store permanent data or instructions. Unlike RAM, the data stored in ROM cannot be easily modified or erased.
**Purpose**: The main purpose of ROM is to hold firmware or system software, such as the bootloader or BIOS, that must be preserved even when the device is powered off.

### 21. FixedPriorityArbiter

**Description**: A fixed priority arbiter is a digital circuit used to grant access to a shared resource (like a bus or memory) among multiple requesters. It assigns a predefined priority order to each request line — for example: REQ[3] > REQ[2] > REQ[1] > REQ[0].
**Purpose**: To ensure that only one requester gets access at a time, always choosing the highest-priority active request.

### 22. RoundRobin(FT)

**Description**: A round robin arbiter is a digital circuit used to fairly allocate access to a shared resource (like a bus or memory) among multiple requesters. 
**Purpose**: To prevent starvation and ensure fairness, especially in systems where all requesters are equally important (e.g., CPUs, DMA, or peripherals competing for memory access).

## TESTBENCHES

All the modules include **testbenches** written in Verilog to verify their functionality using simulation tools. All the simulation results are included in their respective folders.

## TOOLS

1. Verilog HDL
2. Icarus Verilog
3. GTKwave
4. EDAPlayground


Contributions are welcome! If you'd like to add more mini-projects or enhance the existing ones, feel free to open a pull request or issue.
