package cn.dreampie.common;

import org.apache.commons.io.filefilter.DirectoryFileFilter;
import org.apache.commons.io.filefilter.SuffixFileFilter;
import org.junit.Test;

import java.io.File;
import java.io.FileFilter;

/**
 * Created by ice on 14-12-4.
 */
public class FileTest {

  @Test
  public void testCreate() {
    File srcDir = new File("/home/ice/IdeaProjects/jfinal/src/com/jfinal/");
    File destDir = new File("/home/ice/IdeaProjects/package/com/sfinal/");
    createFiles(srcDir, destDir, srcDir);
  }

  private static void createFiles(File srcDir, File destDir, File childDir) {
    if (childDir.exists() && childDir.isDirectory()) {
      if ((destDir.exists() || !destDir.exists() && destDir.mkdirs()) && destDir.isDirectory()) {
        //文件
        File destFile = null;
        String path = "";
        File[] filesInSrcDir = childDir.listFiles((FileFilter) new SuffixFileFilter(".java"));
        for (File file : filesInSrcDir) {
          try {
            path = file.getAbsolutePath().replace(srcDir.getAbsolutePath(), destDir.getAbsolutePath()).replace(".java", ".scala");
            System.out.println("src:" + srcDir.getAbsolutePath());
            System.out.println("dest:" + destDir.getAbsolutePath());
            System.out.println("path:" + path);
            destFile = new File(path);
            if (!destFile.getParentFile().exists())
              destFile.getParentFile().mkdirs();
            destFile.createNewFile();
          } catch (Exception e) {
            e.printStackTrace();
          }
        }
        //目录
        File[] dirs = childDir.listFiles((FileFilter) DirectoryFileFilter.DIRECTORY);
        for (File file : dirs) {
          createFiles(childDir, destDir, file);
        }
      }
    }
  }
}
