#include <linux/module.h>
#include <linux/kernel.h>
#include <linux/init.h>
#include <linux/fs.h>
#include <linux/slab.h>
#include <linux/uaccess.h>
#include <linux/io.h>


#define HELLO_MAJOR 200
#define HELLO_NAME  "hello"

static int hello_open(struct inode *inode, struct file *filp)
{
    printk("hello_drv open\r\n");
    return 0;
}

static int hello_release(struct inode *inode, struct file *filp)
{
    printk("hello_drv release\r\n");
    return 0;
}

static int hello_write(struct file *filp, const char __user *buf, size_t count, loff_t *ppos)
{
    printk("hello_drv write\r\n");
    return 0;
}

static const struct file_operations hello_fops = {
    .owner  = THIS_MODULE,
    .write  = hello_write,
    .open   = hello_open,
    .release= hello_release,
};

static int __init  hello_init(void)
{
    int ret = 0;
    ret = register_chrdev(HELLO_MAJOR, HELLO_NAME, &hello_fops);
    if(ret < 0)
    {
        printk("register chrdev failed!\r\n");
        return -EIO;
    }
    return 0;
}


static void __exit hello_exit(void)
{
    unregister_chrdev(HELLO_MAJOR, HELLO_NAME);
    printk("hello_drv exit\r\n");
}

module_init(hello_init);
module_exit(hello_exit);

MODULE_LICENSE("GPL");
MODULE_AUTHOR("jcyfkimi@gmail.com");
