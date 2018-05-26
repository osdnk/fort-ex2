program main
    use mm
    implicit none
    integer(kind = 4) :: i, j, iret
    real (kind = 8) :: first(3, 5)
    real (kind = 8) :: second(5, 4)
    real (kind = 8) :: multiply(3, 4)
    real (kind = 8) :: dtime
    real (kind = 8) :: mcheck
    integer (kind = 4) :: iclock

    do i = 1, 3
        do j = 1, 5
            first(i,j) = 1;
        end do
    end do

    do i = 1, 5
        do j = 1, 4
            second(i,j) = 1;
        end do
    end do

    call mult(first, second, multiply, iret)

end program main