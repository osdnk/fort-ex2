#if !defined(mod)
#define mod mm
#endif
program main
    use mod
    implicit none
    real :: start, finish
    real (kind = 8), dimension(:,:), allocatable :: mtx1, mtx2, mtx3
    integer(kind = 4) :: ret, i, j
    character(len=32) :: arg
    integer (kind = 8) :: N
    call get_command_argument(1, arg)
    read(arg(1:len_trim(arg)),'(i8)') N
    allocate(mtx1(N,N));
    allocate(mtx2(N,N));
    allocate(mtx3(N,N));
    do i = 1, N
        do j = 1, N
            mtx1(i,j) = 1;
        end do
    end do
    do i = 1, N
        do j = 1, N
            mtx2(i,j) = 1;
        end do
    end do

    call cpu_time(start)
    call mult(mtx1, mtx2, mtx3, ret)
    call cpu_time(finish)
    write(*,*) finish-start

end program main